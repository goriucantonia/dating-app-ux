import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout_shell.dart';
import '../../core/api/api_client.dart';
import '../../core/polling/poller.dart';
import '../analyses/models.dart';
import '../chat/chat_repository.dart';
import '../common/demo_chip.dart';
import '../home/home_screen.dart' show removedCandidatesSentence;
import 'curves.dart';
import 'date_checklist.dart';
import 'dates_repository.dart';
import 'models.dart';

/// `/analyses/:id/results` — the post-date analytics (S13-U10..U13, U15).
///
/// Candidates ordered by `final_score`; **tapping a score reveals its
/// composition** — the four rubric criteria and their weights, verbatim, and
/// the arithmetic recomputed in front of the user so it can be checked
/// against the stored number (AC5). Named trade: this exposes that the
/// weights are opinions, and that is the point.
///
/// Results are fetched once on `complete` — the poller has stopped, and this
/// screen never polls (S13-U15). During `simulating` the same widgets render
/// what exists so far, under a banner saying so (S13-U14).
class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({super.key, required this.analysisId});

  final String analysisId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analysis = ref.watch(analysisPollerProvider(analysisId));
    final dates = ref.watch(datesProvider(analysisId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('How the dates went'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/analyses/$analysisId'),
        ),
      ),
      body: LayoutShell(
        child: analysis.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => _ErrorRetry(
            message: e is ApiException ? e.message : "Couldn't load the results.",
            onRetry: () =>
                ref.read(analysisPollerProvider(analysisId).notifier).refreshNow(),
          ),
          data: (a) => dates.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => _ErrorRetry(
              message: e is ApiException ? e.message : "Couldn't load the dates.",
              onRetry: () => ref.invalidate(datesProvider(analysisId)),
            ),
            data: (payload) => _Body(analysis: a, payload: payload),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.analysis, required this.payload});

  final Analysis analysis;
  final DatesPayload payload;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final a = analysis;
    final stage = a.progress?['stage'] as String?;
    final running = a.status == 'simulating';
    final judgingFailed = stage == 'judging_failed';
    final notJudged = a.progress?['judged'] == false;

    // Ranked by score; unscored last, and unscored is NOT zero.
    final ranked = [...a.candidates]..sort((x, y) {
        final xs = x.finalScore, ys = y.finalScore;
        if (xs == null && ys == null) return x.rank.compareTo(y.rank);
        if (xs == null) return 1;
        if (ys == null) return -1;
        return ys.compareTo(xs);
      });

    final byCandidate = <String, List<DateSummary>>{};
    for (final d in payload.dates) {
      byCandidate.putIfAbsent(d.candidateUserId, () => []).add(d);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (running)
          Card(
            color: theme.colorScheme.tertiaryContainer,
            child: ListTile(
              leading: const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              title: Text('Dates still running',
                  style: TextStyle(color: theme.colorScheme.onTertiaryContainer)),
              subtitle: Text(
                a.progress?['message'] as String? ??
                    'Scores arrive once every date has run.',
                style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
              ),
              onTap: () => context.go('/analyses/${a.id}'),
            ),
          )
        else if (judgingFailed || (a.status == 'complete' && notJudged))
          // Honest, not smoothed over (S13-U13): the dates ran, the scoring
          // did not. The transcripts are still the product.
          Card(
            color: theme.colorScheme.errorContainer,
            child: ListTile(
              leading: Icon(Icons.info_outline,
                  color: theme.colorScheme.onErrorContainer),
              title: Text('The dates ran, but scoring didn’t finish',
                  style: TextStyle(color: theme.colorScheme.onErrorContainer)),
              subtitle: Text(
                a.progress?['message'] as String? ??
                    'The transcripts are safe and you can read them.',
                style: TextStyle(color: theme.colorScheme.onErrorContainer),
              ),
            ),
          ),
        if (a.removedCandidates > 0)
          Card(
            color: theme.colorScheme.surfaceContainerHighest,
            child: ListTile(
              leading: const Icon(Icons.person_off_outlined),
              title: Text(removedCandidatesSentence(a.removedCandidates)),
              subtitle: const Text('Their dates and scores went with them.'),
            ),
          ),
        const SizedBox(height: 8),
        Text('Ranking', style: theme.textTheme.titleMedium),
        const SizedBox(height: 4),
        Text(
          'Scores come from four fixed checks on each date. Tap a score to '
          'see the checks.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        for (var i = 0; i < ranked.length; i++)
          _CandidateResult(
            place: i + 1,
            candidate: ranked[i],
            dates: byCandidate[ranked[i].candidateUserId] ?? const [],
            running: running,
          ),
        if (ranked.isEmpty)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Nobody was matched in this analysis.',
                textAlign: TextAlign.center, style: theme.textTheme.bodyMedium),
          ),
        const SizedBox(height: 24),
        // The footer chat_selection.md owns (S14-U1/U2).
        if (a.status == 'complete' && ranked.isNotEmpty)
          SelectionFooter(analysis: a, candidates: ranked),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _CandidateResult extends StatefulWidget {
  const _CandidateResult({
    required this.place,
    required this.candidate,
    required this.dates,
    required this.running,
  });

  final int place;
  final Candidate candidate;
  final List<DateSummary> dates;
  final bool running;

  @override
  State<_CandidateResult> createState() => _CandidateResultState();
}

class _CandidateResultState extends State<_CandidateResult> {
  bool _showComposition = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final c = widget.candidate;
    final score = c.finalScore;
    final judged = widget.dates
        .where((d) => d.evaluation != null && !d.excludedFromScore)
        .toList();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text('${widget.place}',
                      style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer)),
                ),
                const SizedBox(width: 10),
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
                // S13-U10: the score is a BUTTON. Tapping it shows the checks.
                if (score != null)
                  TextButton(
                    onPressed: () =>
                        setState(() => _showComposition = !_showComposition),
                    child: Column(
                      children: [
                        Text(score.toStringAsFixed(1),
                            style: theme.textTheme.headlineSmall
                                ?.copyWith(color: theme.colorScheme.primary)),
                        Text(_showComposition ? 'hide checks' : 'see checks',
                            style: theme.textTheme.labelSmall),
                      ],
                    ),
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('No score',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(color: theme.colorScheme.outline)),
                      Text(
                        widget.running ? 'not yet' : 'nothing to score',
                        style: theme.textTheme.labelSmall,
                      ),
                    ],
                  ),
              ],
            ),
            if (_showComposition && score != null) ...[
              const SizedBox(height: 8),
              _Composition(candidate: c, judged: judged),
            ],
            const SizedBox(height: 8),
            for (final d in widget.dates) _DateResult(date: d),
            if (widget.dates.isEmpty)
              Text(
                widget.running
                    ? 'Their date hasn’t started yet.'
                    : 'No date was run with ${c.displayName}.',
                style: theme.textTheme.bodySmall,
              ),
          ],
        ),
      ),
    );
  }
}

/// The arithmetic behind a candidate's score, shown so it can be checked by
/// hand (AC5, S13-U10). Every number here is either on the wire or in
/// [rubricWeights]; nothing is invented on this side.
class _Composition extends StatelessWidget {
  const _Composition({required this.candidate, required this.judged});

  final Candidate candidate;
  final List<DateSummary> judged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final versions = judged
        .map((d) => d.evaluation!.rubricVersion)
        .where((v) => v.isNotEmpty)
        .toSet();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('The four checks, and their weights',
              style: theme.textTheme.titleSmall),
          const SizedBox(height: 2),
          Text(
            'These weights are our opinion of what matters on a date. They are '
            'the same for everyone and they are written down here so you can '
            'argue with them.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          for (final c in rubricWeights)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 44,
                    child: Text('${(c.weight * 100).round()}%',
                        style: theme.textTheme.labelLarge),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.label, style: theme.textTheme.bodyMedium),
                        Text(c.plain, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const Divider(),
          for (final d in judged) _DateArithmetic(date: d),
          if (judged.length > 1 || judged.any((d) => d.evaluation!.isPartial)) ...[
            const SizedBox(height: 6),
            Text(_meanLine(), style: theme.textTheme.bodySmall),
          ],
          const SizedBox(height: 6),
          Text(
            'Rubric ${versions.isEmpty ? rubricVersionV1 : versions.join(', ')}'
            '${judged.isNotEmpty ? ' · judged by ${judged.first.evaluation!.judgeModel}' : ''}',
            style: theme.textTheme.labelSmall,
          ),
        ],
      ),
    );
  }

  /// "(94.25×1 + 91.25×0.5) / 1.5 = 93.25" — the candidate mean with partial
  /// dates at half weight (S12-B6), recomputed here from the wire.
  String _meanLine() {
    final parts = <String>[];
    var total = 0.0, weight = 0.0;
    for (final d in judged) {
      final e = d.evaluation!;
      final w = e.isPartial ? partialDateWeight : 1.0;
      parts.add('${e.dateScore.toStringAsFixed(2)}×$w');
      total += e.dateScore * w;
      weight += w;
    }
    final mean = weight == 0 ? 0 : total / weight;
    return 'Across dates: (${parts.join(' + ')}) / $weight = '
        '${mean.toStringAsFixed(2)}'
        '${judged.any((d) => d.evaluation!.isPartial) ? ' — a date that stopped early counts half' : ''}';
  }
}

class _DateArithmetic extends StatelessWidget {
  const _DateArithmetic({required this.date});

  final DateSummary date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final e = date.evaluation!;
    final terms = <String>[];
    for (final c in rubricWeights) {
      final raw = (e.criteria[c.key] as num? ?? 0).round();
      terms.add(c.inverted ? '${c.weight}×(100−$raw)' : '${c.weight}×$raw');
    }
    final recomputed = dateScoreFromCriteria(e.criteria);
    final agrees = (recomputed - e.dateScore).abs() < 0.01;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date.settingName, style: theme.textTheme.labelLarge),
          Text(
            '${terms.join(' + ')} = ${e.dateScore.toStringAsFixed(2)}'
            '${agrees ? '' : ' (we recompute ${recomputed.toStringAsFixed(2)} — mismatch)'}',
            style: theme.textTheme.bodySmall?.copyWith(
              fontFeatures: const [FontFeature.tabularFigures()],
              color: agrees ? null : theme.colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}

/// One date under a candidate (S13-U11, U12, U13).
class _DateResult extends ConsumerStatefulWidget {
  const _DateResult({required this.date});

  final DateSummary date;

  @override
  ConsumerState<_DateResult> createState() => _DateResultState();
}

class _DateResultState extends ConsumerState<_DateResult> {
  bool _showCurves = false;
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final d = widget.date;
    final e = d.evaluation;
    final readable = dateReadable(d);

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  d.settingName.isEmpty ? 'Date ${d.ordinal}' : d.settingName,
                  style: theme.textTheme.titleSmall,
                ),
              ),
              if (e != null && !d.excludedFromScore)
                Text(e.dateScore.toStringAsFixed(1),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: scheme.primary)),
            ],
          ),
          const SizedBox(height: 4),
          Text(endingSentence(status: d.status, endedBy: d.endedBy),
              style: theme.textTheme.bodySmall),
          // S13-U13: excluded / failed, with the reason, never smoothed over.
          if (d.excludedFromScore)
            _Note(
              icon: Icons.block,
              colour: scheme.outline,
              text: d.status == 'failed'
                  ? 'Not scored — ${incompleteReason(d)}'
                  : 'Not scored — too short to judge. ${d.turnCount} '
                      'turn${d.turnCount == 1 ? '' : 's'} were spoken; a date '
                      'needs 10 to be scored at all.',
            )
          else if (d.status == 'incomplete')
            _Note(
              icon: Icons.warning_amber_rounded,
              colour: scheme.tertiary,
              text: '${incompleteReason(d)} Scored from a partial date — '
                  'weighted half.',
            )
          else if (d.status == 'running' || d.status == 'pending')
            _Note(
              icon: Icons.hourglass_empty,
              colour: scheme.outline,
              text: d.status == 'running' ? 'Still running.' : 'Not started yet.',
            ),
          if (d.error != null && d.error!.isNotEmpty) ...[
            TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, minimumSize: const Size(0, 28)),
              onPressed: () => setState(() => _showDetails = !_showDetails),
              child: Text(_showDetails ? 'Hide details' : 'Technical details',
                  style: theme.textTheme.labelSmall),
            ),
            if (_showDetails)
              Text(d.error!,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(fontFamily: 'monospace')),
          ],
          if (e != null) ...[
            if (e.isPartial && !d.excludedFromScore && d.status != 'incomplete')
              _Note(
                icon: Icons.warning_amber_rounded,
                colour: scheme.tertiary,
                text: 'Scored from a partial date — weighted half.',
              ),
            const SizedBox(height: 6),
            if (e.verdictSummary.isNotEmpty)
              Text(e.verdictSummary, style: theme.textTheme.bodyMedium),
            if (e.clickedSubjects.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('What clicked', style: theme.textTheme.labelLarge),
              const SizedBox(height: 4),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final s in e.clickedSubjects) _Pill(text: s),
                ],
              ),
            ],
            const SizedBox(height: 8),
            Text('Where it rubbed', style: theme.textTheme.labelLarge),
            const SizedBox(height: 4),
            if (e.clashes.isEmpty)
              // An empty list is a verdict (§10), and it is said out loud.
              Text('Nothing clashed. That is a real result, not a gap.',
                  style: theme.textTheme.bodySmall)
            else
              for (final c in e.clashes) _ClashSentence(clash: c),
            if (e.perPeerSummary.isNotEmpty) ...[
              const SizedBox(height: 8),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text('Each of you, in one paragraph',
                    style: theme.textTheme.labelLarge),
                children: [
                  for (final entry in e.perPeerSummary.entries)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text('${entry.value}',
                          style: theme.textTheme.bodySmall),
                    ),
                ],
              ),
            ],
          ],
          if (readable) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () => setState(() => _showCurves = !_showCurves),
                  icon: Icon(_showCurves ? Icons.expand_less : Icons.show_chart),
                  label: Text(_showCurves ? 'Hide the curves' : 'How it felt, over time'),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => context.push('/dates/${d.dateId}'),
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text('Read it'),
                ),
              ],
            ),
            if (_showCurves) _Curves(dateId: d.dateId),
          ],
        ],
      ),
    );
  }
}

/// Lazily fetches the transcript (cached for the session — S13-U15) and draws
/// the chart. Tap-through lands on `/dates/:id?seq=N` (AC6).
class _Curves extends ConsumerWidget {
  const _Curves({required this.dateId});

  final String dateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transcript = ref.watch(transcriptProvider(dateId));
    return transcript.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Text(
        e is ApiException ? e.message : "Couldn't load the transcript.",
        style: Theme.of(context).textTheme.bodySmall,
      ),
      data: (t) => SatisfactionChart(
        transcript: t,
        onOpenAt: (seq) => context.push('/dates/$dateId?seq=$seq'),
      ),
    );
  }
}

/// S13-U11: a clash as a plain sentence naming BOTH traits, with the quoted
/// moment the judge cited — the analytics' core promise from the Source of
/// Truth. Chips would bury it.
class _ClashSentence extends StatelessWidget {
  const _ClashSentence({required this.clash});

  final Clash clash;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final base = theme.textTheme.bodyMedium;
    final em = base?.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              style: base,
              children: [
                const TextSpan(text: 'Your '),
                TextSpan(text: clash.userTrait, style: em),
                const TextSpan(text: ' rubbed against their '),
                TextSpan(text: clash.candidateTrait, style: em),
                const TextSpan(text: '.'),
              ],
            ),
          ),
          if (clash.moment.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 2),
              child: Text(
                '“${clash.moment}”',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
        ],
      ),
    );
  }
}

class _Note extends StatelessWidget {
  const _Note({required this.icon, required this.colour, required this.text});

  final IconData icon;
  final Color colour;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: colour),
          const SizedBox(width: 6),
          Expanded(
            child: Text(text,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: colour)),
          ),
        ],
      ),
    );
  }
}

/// A pill that wraps rather than a Chip that truncates (the Step 10 lesson).
class _Pill extends StatelessWidget {
  const _Pill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text,
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.colorScheme.onSecondaryContainer)),
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

/// The Ultimate Match Selection control (S14-U1, U2 — `chat_selection.md`).
///
/// "Choose [name]" per candidate. The confirm sheet states the deal in two
/// lines, because this is where the not-notified honesty has to land: after
/// this tap the app behaves as if a relationship exists. Named trade: one
/// extra tap on the climactic action.
///
/// After selecting, the other candidates' buttons become "already chose
/// [name]" — **visible, not hidden**, so the one-per-analysis rule is
/// legible rather than mysterious.
class SelectionFooter extends ConsumerStatefulWidget {
  const SelectionFooter({super.key, required this.analysis, required this.candidates});

  final Analysis analysis;
  final List<Candidate> candidates;

  @override
  ConsumerState<SelectionFooter> createState() => _SelectionFooterState();
}

class _SelectionFooterState extends ConsumerState<SelectionFooter> {
  bool _busy = false;

  Future<void> _choose(Candidate c) async {
    final name = c.displayName;
    final ok = await showModalBottomSheet<bool>(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose $name?', style: Theme.of(ctx).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(
              "You'll chat with an AI version of $name that remembers your "
              'simulated dates.',
              style: Theme.of(ctx).textTheme.bodyMedium,
            ),
            const SizedBox(height: 6),
            Text(
              "$name won't be notified — real conversations aren't part of "
              'this phase.',
              style: Theme.of(ctx).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'One choice per analysis. You can always run a new analysis later.',
              style: Theme.of(ctx).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: const Text('Not now'),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  child: Text('Choose $name'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    if (ok != true || !mounted) return;

    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    try {
      final session = await ref
          .read(chatRepositoryProvider)
          .select(widget.analysis.id, c.candidateUserId);
      ref.invalidate(chatSessionsProvider);
      router.push('/chat/${session.sessionId}');
    } on AlreadySelected catch (e) {
      // State, not failure: go to the chat that already exists.
      ref.invalidate(chatSessionsProvider);
      if (e.sessionId != null) router.push('/chat/${e.sessionId}');
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      // Every submit ends in a visible outcome (D-005).
      messenger.showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chosen = ref.watch(selectionForAnalysisProvider(widget.analysis.id));
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose one to talk to', style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              chosen == null
                  ? 'You get one choice per analysis. The chat is with an AI '
                      'version of them — they won’t be told.'
                  : 'You chose ${chosen.match.displayName} from this analysis.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            for (final c in widget.candidates)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(c.displayName,
                                style: theme.textTheme.bodyLarge),
                          ),
                          DemoChip(isDemo: c.isDemo, compact: true),
                        ],
                      ),
                    ),
                    if (chosen == null)
                      FilledButton(
                        onPressed: _busy ? null : () => _choose(c),
                        child: Text('Choose ${c.displayName}'),
                      )
                    else if (chosen.match.userId == c.candidateUserId)
                      FilledButton.tonal(
                        onPressed: () => context.push('/chat/${chosen.sessionId}'),
                        child: const Text('Open the chat'),
                      )
                    else
                      // Visible, disabled, and saying why (S14-U2).
                      OutlinedButton(
                        onPressed: null,
                        child: Text('already chose ${chosen.match.displayName}'),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
