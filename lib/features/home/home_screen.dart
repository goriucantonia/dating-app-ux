import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout_shell.dart';
import '../../core/api/api_client.dart';
import '../../core/auth/auth_controller.dart';
import '../../core/polling/poller.dart';
import '../analyses/analyses_repository.dart';
import '../analyses/models.dart';
import '../common/demo_chip.dart';
import '../questions/questions_providers.dart';

/// `/` — the dashboard (S10-U2..U6).
///
/// History is the spine: the hero sits on top of it, not instead of it. A user
/// coming back to this app is usually coming back to something they already
/// started, and burying that under a big button would make the button the only
/// thing the app does.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(analysisHistoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dating App AI'),
        actions: [
          IconButton(
            tooltip: 'Your profile',
            icon: const Icon(Icons.person),
            onPressed: () => context.go('/profile'),
          ),
          IconButton(
            tooltip: 'Sign out',
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authControllerProvider.notifier).logOut(),
          ),
        ],
      ),
      body: LayoutShell(
        child: RefreshIndicator(
          onRefresh: () async => ref.invalidate(analysisHistoryProvider),
          child: history.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => _ErrorRetry(
              message: e is ApiException
                  ? e.message
                  : "Couldn't load your analyses.",
              onRetry: () => ref.invalidate(analysisHistoryProvider),
            ),
            data: (analyses) => _Body(analyses: analyses),
          ),
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.analyses});

  final List<Analysis> analyses;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final running = analyses
        .where((a) => a.status == 'matching' || a.status == 'simulating')
        .firstOrNull;
    final latestDone = analyses
        .where((a) => a.status == 'matched' || a.status == 'complete')
        .firstOrNull;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 8),
        if (running != null)
          // S10-U3: the hero MORPHS into a live progress card rather than
          // being replaced by an error. The server's 409 is pre-empted here so
          // the user never sees a rejection for pressing a button twice.
          _RunningCard(analysisId: running.id)
        else
          const _Hero(),
        if (latestDone != null && running == null) ...[
          const SizedBox(height: 12),
          _LatestResultCard(analysis: latestDone),
        ],
        const SizedBox(height: 28),
        Text('Your analyses', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        if (analyses.isEmpty)
          _EmptyHistory()
        else
          for (final a in analyses) _HistoryRow(analysis: a),
        const SizedBox(height: 32),
      ],
    );
  }
}

/// S10-U2 / U3. The one big button, and the reason it might not be pressable.
class _Hero extends ConsumerStatefulWidget {
  const _Hero();

  @override
  ConsumerState<_Hero> createState() => _HeroState();
}

class _HeroState extends ConsumerState<_Hero> {
  bool _busy = false;

  Future<void> _start() async {
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    try {
      final analysis = await ref.read(analysesRepositoryProvider).start();
      ref.invalidate(analysisHistoryProvider);
      router.go('/analyses/${analysis.id}');
    } on AnalysisAlreadyRunning catch (e) {
      // State, not failure — go and watch the one that is already running.
      ref.invalidate(analysisHistoryProvider);
      router.go('/analyses/${e.analysisId}');
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // S10-U3, third state: name the ACTUAL blocker and link to it. "You are
    // not eligible" tells someone nothing they can act on.
    final incomplete = baselineIncomplete(ref.watch(questionsProvider));
    if (incomplete == true) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(Icons.edit_note, size: 40, color: theme.colorScheme.primary),
              const SizedBox(height: 12),
              Text('Finish your 5 questions first',
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                'Matching reads your answers. Without them there is nothing '
                'to match on.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.go('/onboarding/questions'),
                child: const Text('Answer them'),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(Icons.favorite, size: 44, color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            Text('Find the Right Person',
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              'We compare you with everyone open to matching, then simulate '
              'dates with the best few.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _busy ? null : _start,
                icon: _busy
                    ? const SizedBox(
                        width: 18, height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.search),
                label: Text(_busy ? 'Starting…' : 'Find the Right Person'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The hero's "already running" form. Subscribed to the SHARED poller, so this
/// card and the analysis screen are the same loop (S10-U1, AC2).
class _RunningCard extends ConsumerWidget {
  const _RunningCard({required this.analysisId});

  final String analysisId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(analysisPollerProvider(analysisId));
    final status = state.valueOrNull?.status ?? 'matching';
    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: InkWell(
        onTap: () => context.go('/analyses/$analysisId'),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const SizedBox(
                width: 22, height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your analysis is running',
                        style: theme.textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                      status == 'simulating'
                          // S13-U1: the server's own stage sentence, here too.
                          ? (state.valueOrNull?.progress?['message'] as String? ??
                              'Running the dates…')
                          : 'Checking who fits…',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

/// S10-U4.
class _LatestResultCard extends StatelessWidget {
  const _LatestResultCard({required this.analysis});

  final Analysis analysis;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final top = analysis.candidates.firstOrNull;
    if (top == null) return const SizedBox.shrink();
    return Card(
      child: InkWell(
        onTap: () => context.go('/analyses/${analysis.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Continue where you left off',
                        style: theme.textTheme.labelMedium),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            '${top.displayName}, ${top.age}',
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        DemoChip(isDemo: top.isDemo, compact: true),
                      ],
                    ),
                  ],
                ),
              ),
              Text('${(top.compatibility * 100).round()}%',
                  style: theme.textTheme.titleLarge
                      ?.copyWith(color: theme.colorScheme.primary)),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

/// S10-U5.
class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.analysis});

  final Analysis analysis;

  (String, Color) _chip(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (analysis.status) {
      'matching' => ('Matching', scheme.tertiary),
      'simulating' => ('Simulating', scheme.tertiary),
      'matched' => ('Matched', scheme.primary),
      'complete' => ('Complete', scheme.primary),
      'no_candidates' => ('No one yet', scheme.outline),
      _ => ('Failed', scheme.error),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (label, colour) = _chip(context);
    final top = analysis.candidates.firstOrNull;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: () => context.go('/analyses/${analysis.id}'),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: colour.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(label,
                  style: theme.textTheme.labelSmall?.copyWith(color: colour)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                analysis.createdAt.split('T').first,
                style: theme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
        subtitle: top == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  children: [
                    Flexible(child: Text('${top.displayName}, ${top.age}')),
                    DemoChip(isDemo: top.isDemo, compact: true),
                    const SizedBox(width: 8),
                    Text('${(top.compatibility * 100).round()}%',
                        style: theme.textTheme.labelLarge),
                  ],
                ),
              ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          "You haven't run one yet. When you do, every analysis stays here so "
          'you can come back to it.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
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
