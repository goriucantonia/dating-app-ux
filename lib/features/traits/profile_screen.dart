import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout_shell.dart';
import '../../app/theme.dart';
import '../../core/api/api_client.dart';
import '../persona/persona_repository.dart';
import '../questions/models.dart' show Question;
import '../questions/questions_providers.dart';
import 'models.dart';
import 'traits_repository.dart';

/// `/profile` — what the AI thinks it knows about you, and one tap to correct
/// it (S8-U1..U5, U9).
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final traits = ref.watch(traitsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your profile'),
      ),
      body: LayoutShell(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(traitsProvider);
            ref.invalidate(personaProvider);
          },
          child: traits.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => _ErrorRetry(
              message: e is ApiException ? e.message : "Couldn't load your profile.",
              onRetry: () => ref.invalidate(traitsProvider),
            ),
            data: (payload) => _Body(payload: payload),
          ),
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.payload});

  final TraitsPayload payload;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retracted traits are returned by the API on purpose (a retraction is an
    // event, not a disappearance) but the profile is not a history view — the
    // person asked "what do you think of me", not "what did you once think".
    final live =
        payload.traits.where((t) => t.status != 'retracted').toList();

    if (live.isEmpty) {
      return ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          SizedBox(height: 48),
          _PersonaHeaderSlot(),
          SizedBox(height: 24),
          Center(
            child: Text(
              "Nothing here yet — your answers haven't been read into traits.",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    final sections = <Widget>[];
    for (final category in traitCategoryOrder) {
      final rows = live.where((t) => t.category == category).toList();
      if (rows.isEmpty) continue;
      sections.add(Padding(
        padding: const EdgeInsets.fromLTRB(4, 20, 4, 8),
        child: Text(
          traitCategoryLabels[category] ?? category,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ));
      sections.addAll(rows.map((t) => _TraitCard(trait: t)));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _PersonaHeaderSlot(),
        const SizedBox(height: 8),
        // S18-U3: corrections you started and have not finished, at the top of
        // the screen they belong to. This is the "you won't have to go
        // looking for it" the dispute dialog promises.
        const _WaitingCorrections(),
        // S8-U9: expansion is reachable from the profile now that there is a
        // trait list for it to visibly change.
        OutlinedButton.icon(
          onPressed: () => context.push('/profile/expand'),
          icon: const Icon(Icons.add_comment),
          label: const Text('Answer more questions'),
        ),
        const SizedBox(height: 8),
        FilledButton.tonalIcon(
          onPressed: () => context.push('/profile/calibration'),
          icon: const Icon(Icons.forum),
          label: const Text('Talk to your AI self'),
        ),
        ...sections,
        const SizedBox(height: 32),
      ],
    );
  }
}

/// S18-U3. Every dispute question the user has not answered yet, listed where
/// they will see it: at the top of the profile the disputed trait sits on.
///
/// Renders nothing at all when there is nothing waiting — an empty "0
/// corrections" block would be noise on the screen a person visits most.
class _WaitingCorrections extends ConsumerWidget {
  const _WaitingCorrections();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(questionsProvider);
    final waiting = (questions.valueOrNull ?? const <Question>[])
        .where((q) => q.origin == 'dispute' && !q.answered)
        .toList();
    if (waiting.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final m = Modernist.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      color: m.tint,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Kicker(
            waiting.length == 1
                ? '1 correction waiting'
                : '${waiting.length} corrections waiting',
            colour: m.onTint,
          ),
          const SizedBox(height: 6),
          Text(
            'You told us the AI got something wrong. Answering this is how it '
            'learns what is actually true.',
            style: theme.textTheme.bodySmall?.copyWith(color: m.onTint),
          ),
          const SizedBox(height: 10),
          for (final q in waiting)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: InkWell(
                onTap: () => context.push('/profile/correct/${q.id}'),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        q.text,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: m.onTint),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('Answer →',
                        style: theme.textTheme.labelSmall
                            ?.copyWith(color: m.onTint)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// S8-U4. Snapshot state, and the one place a rebuild is offered by hand.
class _PersonaHeaderSlot extends ConsumerWidget {
  const _PersonaHeaderSlot();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final persona = ref.watch(personaProvider);
    return persona.when(
      loading: () => const SizedBox(height: 4, child: LinearProgressIndicator()),
      error: (_, _) => const SizedBox.shrink(),
      data: (state) {
        final snap = state.snapshot;
        if (snap == null) {
          return _HeaderCard(
            icon: Icons.hourglass_empty,
            text: 'Your AI self hasn’t been built yet.',
            actionLabel: 'Build it',
            onAction: () => _rebuild(context, ref),
          );
        }
        if (snap.status == 'compiling') {
          return const _HeaderCard(
            icon: Icons.autorenew,
            text: 'Rebuilding your AI self…',
          );
        }
        if (snap.status == 'failed') {
          return _HeaderCard(
            icon: Icons.error_outline,
            tone: _Tone.error,
            text: 'The last rebuild didn’t finish. Your previous version is '
                'still in use.',
            actionLabel: 'Try again',
            onAction: () => _rebuild(context, ref),
          );
        }
        if (snap.stale) {
          return _HeaderCard(
            icon: Icons.sync_problem,
            tone: _Tone.warning,
            text: 'Profile changed — your AI self will rebuild.',
            actionLabel: 'Rebuild now',
            onAction: () => _rebuild(context, ref),
          );
        }
        return _HeaderCard(
          icon: Icons.verified,
          text: 'AI self v${snap.version} · up to date',
        );
      },
    );
  }

  Future<void> _rebuild(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(personaRepositoryProvider).startCompile();
      ref.invalidate(personaProvider);
      messenger.showSnackBar(
        const SnackBar(content: Text('Rebuilding your AI self…')),
      );
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}

enum _Tone { normal, warning, error }

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.icon,
    required this.text,
    this.actionLabel,
    this.onAction,
    this.tone = _Tone.normal,
  });

  final IconData icon;
  final String text;
  final String? actionLabel;
  final VoidCallback? onAction;
  final _Tone tone;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (bg, fg) = switch (tone) {
      _Tone.normal => (scheme.surfaceContainerHighest, scheme.onSurface),
      _Tone.warning => (scheme.tertiaryContainer, scheme.onTertiaryContainer),
      _Tone.error => (scheme.errorContainer, scheme.onErrorContainer),
    };
    return Card(
      color: bg,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Row(
          children: [
            Icon(icon, color: fg, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: fg)),
            ),
            if (actionLabel != null)
              TextButton(onPressed: onAction, child: Text(actionLabel!)),
          ],
        ),
      ),
    );
  }
}

/// S8-U2. **A guess must look like a guess** (§9).
///
/// `inferred` gets a dotted border and says so in words; `confirmed` is solid;
/// `disputed` is amber and says it is being corrected. Confidence is a 3-step
/// strength dot, deliberately NOT a percentage — "0.62 confident you're
/// stubborn" is absurd theater, and a number invites arguing with the decimal
/// instead of the claim (named trade).
class _TraitCard extends ConsumerStatefulWidget {
  const _TraitCard({required this.trait});

  final Trait trait;

  @override
  ConsumerState<_TraitCard> createState() => _TraitCardState();
}

class _TraitCardState extends ConsumerState<_TraitCard> {
  late String _status = widget.trait.status;
  bool _busy = false;

  Future<void> _confirm() async {
    final previous = _status;
    // Optimistic: a single-row write is the one place optimism is safe (S8-U3).
    setState(() {
      _status = 'confirmed';
      _busy = true;
    });
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(traitsRepositoryProvider).confirm(widget.trait.id);
      ref.invalidate(personaProvider); // status change moves traits_hash
    } on ApiException catch (e) {
      if (mounted) setState(() => _status = previous); // rollback
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (mounted) setState(() => _status = previous);
      messenger.showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _dispute() async {
    final previous = _status;
    setState(() {
      _status = 'disputed';
      _busy = true;
    });
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    try {
      final result =
          await ref.read(traitsRepositoryProvider).dispute(widget.trait.id);
      ref.invalidate(questionsProvider);
      ref.invalidate(personaProvider);
      if (!mounted) return;
      // S8-U3: tell them a question was added, and take them to it. A dispute
      // that only recolours a card leaves the user with no way to correct
      // anything, which is the opposite of what they just asked for.
      // S18-U3. NO snackbar promising a question the user then has to hunt
      // for: the dialog IS the question, and both roads out of it lead
      // somewhere that exists. "Later" is honest because the profile now
      // carries a waiting-corrections banner that leads back here.
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Tell us what’s actually true'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(result.questionText,
                  style: Theme.of(ctx).textTheme.bodyMedium),
              const SizedBox(height: 12),
              Text(
                'It’s waiting on your profile until you do — you won’t have to '
                'go looking for it.',
                style: Theme.of(ctx).textTheme.bodySmall,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Later'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                router.push('/profile/correct/${result.questionId}');
              },
              child: const Text('Answer now'),
            ),
          ],
        ),
      );
    } on ApiException catch (e) {
      if (mounted) setState(() => _status = previous);
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (mounted) setState(() => _status = previous);
      messenger.showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final t = widget.trait;

    final (borderColor, borderWidth, dotted, note) = switch (_status) {
      'confirmed' => (scheme.primary, 1.5, false, 'You confirmed this'),
      'disputed' => (scheme.tertiary, 1.5, false, 'Being corrected'),
      'corrected' => (scheme.primary, 1.5, false, 'Corrected by you'),
      _ => (scheme.outlineVariant, 1.0, true, 'AI’s read, not confirmed'),
    };

    final card = Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: dotted ? null : Border.all(color: borderColor, width: borderWidth),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(t.label,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ),
              _StrengthDots(confidence: t.confidence),
            ],
          ),
          const SizedBox(height: 6),
          Text(t.description, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                _status == 'confirmed'
                    ? Icons.check_circle
                    : _status == 'disputed'
                        ? Icons.build_circle
                        : Icons.help_outline,
                size: 14,
                color: _status == 'inferred' ? scheme.outline : borderColor,
              ),
              const SizedBox(width: 4),
              Text(note,
                  style: theme.textTheme.labelSmall?.copyWith(
                      color: _status == 'inferred' ? scheme.outline : borderColor)),
              const Spacer(),
              if (_busy)
                const SizedBox(
                    width: 16, height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2))
              else if (_status != 'confirmed' && _status != 'disputed') ...[
                TextButton(
                    onPressed: _dispute, child: const Text("That's wrong")),
                const SizedBox(width: 4),
                FilledButton.tonal(
                    onPressed: _confirm, child: const Text("That's right")),
              ] else if (_status == 'disputed')
                TextButton(
                    onPressed: () => context.push('/profile/expand'),
                    child: const Text('Answer the question')),
            ],
          ),
        ],
      ),
    );

    // A dotted border is not a BoxDecoration primitive; painting it is the
    // honest way to make "this is a guess" visible at a glance in both themes.
    return dotted
        ? CustomPaint(
            painter: _DottedBorderPainter(color: scheme.outlineVariant),
            child: card,
          )
        : card;
  }
}

class _StrengthDots extends StatelessWidget {
  const _StrengthDots({required this.confidence});

  final double confidence;

  @override
  Widget build(BuildContext context) {
    // Three steps, never a percentage (S8-U2, named trade).
    final filled = confidence >= 0.8 ? 3 : (confidence >= 0.55 ? 2 : 1);
    final scheme = Theme.of(context).colorScheme;
    return Tooltip(
      message: switch (filled) {
        3 => 'Strong read',
        2 => 'Moderate read',
        _ => 'Tentative read',
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          3,
          (i) => Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i < filled ? scheme.primary : scheme.outlineVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  const _DottedBorderPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 6, size.width, size.height - 12),
      const Radius.circular(12),
    );
    final path = Path()..addRRect(rect);
    const dash = 5.0;
    const gap = 4.0;
    for (final metric in path.computeMetrics()) {
      var d = 0.0;
      while (d < metric.length) {
        canvas.drawPath(
          metric.extractPath(d, (d + dash).clamp(0, metric.length)),
          paint,
        );
        d += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DottedBorderPainter old) => old.color != color;
}

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off, size: 48),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          FilledButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
    );
  }
}
