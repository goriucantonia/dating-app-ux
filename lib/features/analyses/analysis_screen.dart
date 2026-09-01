import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout_shell.dart';
import '../../core/api/api_client.dart';
import '../../core/notify/local_notification.dart';
import '../../core/polling/poller.dart';
import '../common/demo_chip.dart';
import '../dates/date_checklist.dart';
import '../dates/dates_repository.dart';
import '../home/home_screen.dart' show removedCandidatesSentence;
import '../traits/models.dart' show traitCategoryLabels, traitCategoryOrder;
import 'analyses_repository.dart';
import 'models.dart';

/// `/analyses/:id` — **ONE route, phase-switched by status** (S10-U7).
///
/// Named trade: the analysis is one server object with one lifecycle, so the
/// UI is one route that renders differently. Splitting it into
/// `/analyses/:id/matching`, `/analyses/:id/results` and so on would invent
/// client state the server does not have, and every deep link would then need
/// to guess which of them is currently true.
///
/// Deep links land correctly in any phase (S10-U13) precisely because of that:
/// the route reads the status it is given.
///
/// Step 13 fills in phase 3 (`simulating` — S13-U1..U4), the `failed` state
/// (S13-U5), and the hand-off from `complete` to the results screen, which
/// IS a separate route: the results are a different page, not a different
/// phase of this object.
class AnalysisScreen extends ConsumerWidget {
  const AnalysisScreen({super.key, required this.analysisId});

  final String analysisId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(analysisPollerProvider(analysisId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finding the right person'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: LayoutShell(
        child: state.when(
          loading: () => const _Phase(
            icon: Icons.hourglass_empty,
            title: 'Opening your analysis…',
          ),
          error: (e, _) => _ErrorRetry(
            message: e is ApiException ? e.message : "Couldn't load this analysis.",
            onRetry: () =>
                ref.read(analysisPollerProvider(analysisId).notifier).refreshNow(),
          ),
          data: (analysis) => switch (analysis.status) {
            // Phase 1 (S10-U7).
            'matching' => const _Phase(
                icon: Icons.search,
                title: 'Checking who fits…',
                subtitle: 'Comparing you with everyone who is open to matching.',
                spinner: true,
              ),
            // Phase 3 (S13-U1..U4).
            'simulating' => _SimulatingPhase(analysis: analysis),
            // S10-U6 / U10: honest, calm, and with NO simulate button.
            'no_candidates' => _Phase(
                icon: Icons.person_search,
                title: 'No one fits your filters yet',
                subtitle: analysis.message ??
                    'There is no one to match you with yet.',
                footnote:
                    'Nothing has gone wrong. As more people join and open '
                    'themselves to matching, this will fill up.',
              ),
            // S13-U5: name the stage that died; retry RESUMES.
            'failed' => _FailedPhase(analysis: analysis),
            // Phase 2 (S10-U8): the reveal — and, once complete, the door to
            // the results.
            _ => _Reveal(analysis: analysis),
          },
        ),
      ),
    );
  }
}

/// Phase 3: the wait, made watchable (S13-U1..U4).
///
/// Real stage names from the server's `progress`, never a fake percentage
/// bar; the checklist of dates under it; finished dates open immediately
/// (S13-U3 — the rows are already checkpointed, so this is free); and the
/// one thing this screen most needs to say: you can leave.
class _SimulatingPhase extends ConsumerWidget {
  const _SimulatingPhase({required this.analysis});

  final Analysis analysis;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dates = ref.watch(datesProvider(analysis.id));
    final message = analysis.progress?['message'] as String? ??
        'Getting the first date started.';
    final stage = analysis.progress?['stage'] as String?;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stage == 'judging' ? 'Scoring the dates…' : 'Running the dates…',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  // S11-B10 / S13-U1: the SERVER's sentence for the real stage.
                  Text(message, style: theme.textTheme.bodyLarge),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // S13-U4: the prominent affordance.
        Card(
          color: theme.colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(Icons.exit_to_app,
                    color: theme.colorScheme.onPrimaryContainer),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('You can leave — this keeps running.',
                          style: theme.textTheme.titleSmall?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer)),
                      Text(
                        'Close the app, come back later. We’ll show a note '
                        'when the dates have finished.',
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text('The dates', style: theme.textTheme.titleMedium),
        const SizedBox(height: 4),
        Text(
          'Finished ones open right away — you don’t have to wait for the rest.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        dates.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
          // A failed date-list read is not the analysis failing: the poller
          // still has the truth. Say so, quietly, and let the next progress
          // change refetch.
          error: (e, _) => Text(
            e is ApiException
                ? e.message
                : "Couldn't load the date list just now — it refreshes on its own.",
            style: theme.textTheme.bodySmall,
          ),
          data: (payload) => DateChecklist(dates: payload.dates),
        ),
        const SizedBox(height: 24),
        Center(
          child: TextButton(
            onPressed: () => context.go('/analyses/${analysis.id}/results'),
            child: const Text('See what there is so far'),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

/// S13-U5: a `failed` analysis names the stage that died, and the retry
/// **resumes** — the server keeps every checkpointed row, `ensure_dates`
/// reuses them, and a finished date is a no-op on re-run. So the copy says
/// what is true: "picks up where it stopped".
///
/// A failure in MATCHING (no candidates yet) has nothing to resume, and the
/// server refuses `/simulate` for it; the honest action there is a new
/// analysis, and that is the button shown.
class _FailedPhase extends ConsumerStatefulWidget {
  const _FailedPhase({required this.analysis});

  final Analysis analysis;

  @override
  ConsumerState<_FailedPhase> createState() => _FailedPhaseState();
}

class _FailedPhaseState extends ConsumerState<_FailedPhase> {
  bool _busy = false;
  bool _showDetails = false;

  Future<void> _resume() async {
    setState(() => _busy = true);
    try {
      await ref.read(analysesRepositoryProvider).simulate(widget.analysis.id);
      // The server flips the row in a background task; keep polling through
      // the `failed` it may still report for a moment.
      await ref
          .read(analysisPollerProvider(widget.analysis.id).notifier)
          .kick();
      // Still here (the row has not flipped yet)? Hand the button back
      // rather than spinning forever over a request that was accepted.
      if (mounted) setState(() => _busy = false);
    } catch (e) {
      if (!mounted) return;
      setState(() => _busy = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e is ApiException
            ? e.message
            : "Couldn't pick it up just now. Try again in a moment."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final a = widget.analysis;
    final stage = a.progress?['stage'] as String?;
    final resumable = a.candidates.isNotEmpty;
    final stageName = switch (stage) {
      null when !resumable => 'while working out who fits',
      null => 'before the dates started',
      'queued' => 'while waiting for a free slot',
      'simulating' => 'during the dates',
      'judging' => 'while scoring the dates',
      _ => 'at the "$stage" stage',
    };
    final lastMessage = a.progress?['message'] as String?;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.report_problem_outlined,
                size: 56, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text('This analysis stopped $stageName',
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center),
            if (lastMessage != null) ...[
              const SizedBox(height: 8),
              Text('Last thing it was doing: $lastMessage',
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center),
            ],
            const SizedBox(height: 16),
            if (resumable) ...[
              FilledButton.icon(
                onPressed: _busy ? null : _resume,
                icon: _busy
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.play_arrow),
                label: Text(_busy ? 'Picking up…' : 'Pick up where it stopped'),
              ),
              const SizedBox(height: 8),
              Text(
                'Nothing is redone. Every message already spoken is kept, and '
                'the dates continue from the last one.',
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ] else ...[
              FilledButton.icon(
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.refresh),
                label: const Text('Start a new analysis'),
              ),
              const SizedBox(height: 8),
              Text(
                'Nobody had been matched yet, so there is nothing to pick up.',
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
            if (a.error != null && a.error!.isNotEmpty) ...[
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => setState(() => _showDetails = !_showDetails),
                child: Text(_showDetails ? 'Hide details' : 'Technical details'),
              ),
              if (_showDetails)
                Text(a.error!,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontFamily: 'monospace'),
                    textAlign: TextAlign.center),
            ],
          ],
        ),
      ),
    );
  }
}

class _Reveal extends StatelessWidget {
  const _Reveal({required this.analysis});

  final Analysis analysis;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final partial = analysis.poolStatus == 'partial';
    final complete = analysis.status == 'complete';
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (complete) ...[
          // The door to the results (S13-U10). Above the cards, because a
          // returning user is here for the outcome, not the reveal.
          Card(
            color: theme.colorScheme.primaryContainer,
            child: ListTile(
              leading: Icon(Icons.auto_awesome,
                  color: theme.colorScheme.onPrimaryContainer),
              title: Text('The dates have run',
                  style: TextStyle(color: theme.colorScheme.onPrimaryContainer)),
              subtitle: Text(
                analysis.progress?['message'] as String? ??
                    'See how each one went.',
                style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go('/analyses/${analysis.id}/results'),
            ),
          ),
          const SizedBox(height: 12),
        ],
        Text(
          analysis.candidates.length == 1
              ? 'One person fits'
              : '${analysis.candidates.length} people fit',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        if (analysis.removedCandidates > 0)
          // S15-U2: the gap, labeled. Their dates went with them.
          Card(
            color: theme.colorScheme.surfaceContainerHighest,
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: const Icon(Icons.person_off_outlined),
              title: Text(removedCandidatesSentence(analysis.removedCandidates)),
              subtitle: const Text(
                  'Their dates and scores went with them. What is left is real.'),
            ),
          ),
        if (partial)
          // S10-U10. Plain, not apologetic: a small pool is a fact about the
          // world, not a failure of the app.
          Card(
            color: theme.colorScheme.tertiaryContainer,
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Only ${analysis.candidates.length} '
                '${analysis.candidates.length == 1 ? "person fits" : "people fit"} '
                'your filters right now — simulating with them.',
                style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onTertiaryContainer),
              ),
            ),
          ),
        for (var i = 0; i < analysis.candidates.length; i++)
          _StaggeredIn(
            index: i,
            child: _CandidateCard(candidate: analysis.candidates[i]),
          ),
        const SizedBox(height: 20),
        // S10-U12: an explicit button, NOT auto-chained. The reveal is a
        // decision point — the user looks at who was found and chooses.
        //
        // Only on `matched`. A finished analysis renders this same reveal, and
        // offering it a live "Start Simulated Dates" button would be offering
        // an action the server answers with a 409 every time — a button that
        // can only ever fail is worse than no button (§11: gate the promise on
        // the capability).
        if (analysis.status == 'matched')
          _SimulateButton(analysisId: analysis.id)
        else if (complete)
          Center(
            child: FilledButton.icon(
              onPressed: () => context.go('/analyses/${analysis.id}/results'),
              icon: const Icon(Icons.insights),
              label: const Text('See the results'),
            ),
          ),
        const SizedBox(height: 32),
      ],
    );
  }
}

/// A light stagger so the cards arrive rather than appear. Deliberately small:
/// this is a reveal, not a slot machine, and the numbers on the cards are the
/// point.
class _StaggeredIn extends StatelessWidget {
  const _StaggeredIn({required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 260 + index * 120),
      curve: Curves.easeOut,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(offset: Offset(0, (1 - t) * 12), child: child),
      ),
      child: child,
    );
  }
}

class _CandidateCard extends StatefulWidget {
  const _CandidateCard({required this.candidate});

  final Candidate candidate;

  @override
  State<_CandidateCard> createState() => _CandidateCardState();
}

class _CandidateCardState extends State<_CandidateCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final c = widget.candidate;
    final percent = (c.compatibility * 100).round();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text('${c.displayName}, ${c.age}',
                            style: theme.textTheme.titleLarge),
                      ),
                      DemoChip(isDemo: c.isDemo),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('$percent%',
                        style: theme.textTheme.headlineSmall
                            ?.copyWith(color: theme.colorScheme.primary)),
                    Text('fit', style: theme.textTheme.labelSmall),
                    // Once judged, the date score sits beside the fit — the
                    // two are different things and both are shown.
                    if (c.finalScore != null) ...[
                      const SizedBox(height: 4),
                      Text(c.finalScore!.toStringAsFixed(1),
                          style: theme.textTheme.titleMedium),
                      Text('date score', style: theme.textTheme.labelSmall),
                    ],
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (c.sharedInterests.isNotEmpty)
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final s in c.sharedInterests)
                    Chip(
                      label: Text(s),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                ],
              ),
            const SizedBox(height: 8),
            // Computed server-side and never generated (trade #3). Rendered
            // verbatim for the same reason.
            Text(c.reasonSummary, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => setState(() => _expanded = !_expanded),
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                label: Text(_expanded ? 'Hide breakdown' : 'Why them?'),
              ),
            ),
            if (_expanded) _Breakdown(candidate: c),
          ],
        ),
      ),
    );
  }
}

/// S10-U11. Trait LABELS by category — descriptions stay private to the
/// candidate. The server does not send them; this widget could not show them
/// if it wanted to.
class _Breakdown extends StatelessWidget {
  const _Breakdown({required this.candidate});

  final Candidate candidate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labels = candidate.traitLabels;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Row(
          children: [
            Text('How you two score',
                style: theme.textTheme.titleSmall),
            DemoChip(isDemo: candidate.isDemo, compact: true),
          ],
        ),
        const SizedBox(height: 6),
        _Bar(label: 'They fit what you want',
            value: candidate.fitForward),
        _Bar(label: 'You fit what they want',
            value: candidate.fitBackward),
        const SizedBox(height: 12),
        if (labels.isEmpty)
          Text('No traits to show yet.', style: theme.textTheme.bodySmall)
        else
          for (final category in traitCategoryOrder)
            if ((labels[category] ?? const []).isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Text(
                  traitCategoryLabels[category] ?? category,
                  style: theme.textTheme.labelLarge,
                ),
              ),
              // Deliberately NOT `Chip`: a Chip lays its label out on one
              // line, so a long trait label gets truncated. Trait labels are
              // SUPPOSED to be short ("restores old bicycles"), but the
              // extraction model sometimes writes a whole sentence — and these
              // labels are the only thing shown about this person, so losing
              // half of one loses the content rather than trimming a
              // decoration. A pill that wraps costs a line and keeps the words.
              for (final l in labels[category]!)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(l, style: theme.textTheme.bodyMedium),
                ),
            ],
      ],
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(label, style: theme.textTheme.bodySmall)),
              Text('${(value * 100).round()}%',
                  style: theme.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value.clamp(0, 1),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

class _Phase extends StatelessWidget {
  const _Phase({
    required this.icon,
    required this.title,
    this.subtitle,
    this.footnote,
    this.spinner = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? footnote;
  final bool spinner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (spinner)
              const CircularProgressIndicator()
            else
              Icon(icon, size: 56, color: theme.colorScheme.primary),
            const SizedBox(height: 20),
            Text(title,
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center),
            if (subtitle != null) ...[
              const SizedBox(height: 10),
              Text(subtitle!,
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center),
            ],
            if (footnote != null) ...[
              const SizedBox(height: 16),
              Text(footnote!,
                  style: theme.textTheme.bodySmall,
                  textAlign: TextAlign.center),
            ],
          ],
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
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, size: 48),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}

/// The one control that turns a list of names into simulated evenings
/// (S11-B11).
///
/// Stateful for one reason: between the tap and the server's 202 there are a
/// few seconds where the poller still reports `matched`, and a button that
/// looks untouched in that window gets pressed twice. The local `_starting`
/// flag covers exactly that gap and nothing else — the moment the poller sees
/// `simulating`, the whole screen switches phase and this widget is gone.
class _SimulateButton extends ConsumerStatefulWidget {
  const _SimulateButton({required this.analysisId});

  final String analysisId;

  @override
  ConsumerState<_SimulateButton> createState() => _SimulateButtonState();
}

class _SimulateButtonState extends ConsumerState<_SimulateButton> {
  bool _starting = false;

  Future<void> _start() async {
    setState(() => _starting = true);
    // S13-U4: the browser only grants notification permission from a user
    // gesture, and this tap is the one that means "I might walk away".
    await requestNotificationPermission();
    try {
      await ref.read(analysesRepositoryProvider).simulate(widget.analysisId);
      await ref
          .read(analysisPollerProvider(widget.analysisId).notifier)
          .kick();
    } catch (e) {
      // D-005: a submit that fails must SAY so. Catching only ApiException
      // here would leave a storage- or transport-level failure showing the
      // user a button that quietly went back to normal.
      if (!mounted) return;
      setState(() => _starting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e is ApiException
              ? e.message
              : "Couldn't start the dates just now. Try again in a moment."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        FilledButton.icon(
          onPressed: _starting ? null : _start,
          icon: _starting
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.play_arrow),
          label: Text(_starting ? 'Starting…' : 'Start Simulated Dates'),
        ),
        const SizedBox(height: 6),
        Center(
          child: Text(
            'One date with each person. It takes a while, and it keeps '
            'running whether you watch or not.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
