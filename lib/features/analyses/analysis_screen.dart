import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout_shell.dart';
import '../../core/api/api_client.dart';
import '../../core/polling/poller.dart';
import '../common/demo_chip.dart';
import '../traits/models.dart' show traitCategoryLabels, traitCategoryOrder;
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
            'simulating' => const _Phase(
                icon: Icons.movie_filter,
                title: 'Running the dates…',
                subtitle: 'This arrives properly in a later build step.',
                spinner: true,
              ),
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
            'failed' => _ErrorRetry(
                message: analysis.error != null
                    ? "That analysis didn't finish."
                    : 'That analysis failed.',
                onRetry: () => ref
                    .read(analysisPollerProvider(analysisId).notifier)
                    .refreshNow(),
              ),
            // Phase 2 (S10-U8): the reveal.
            _ => _Reveal(analysis: analysis),
          },
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
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          analysis.candidates.length == 1
              ? 'One person fits'
              : '${analysis.candidates.length} people fit',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
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
        FilledButton.icon(
          onPressed: null,
          icon: const Icon(Icons.play_arrow),
          label: const Text('Start Simulated Dates'),
        ),
        const SizedBox(height: 6),
        Center(
          child: Text('Simulated dates arrive in the next build step.',
              style: theme.textTheme.bodySmall),
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
                Text('$percent%',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(color: theme.colorScheme.primary)),
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
