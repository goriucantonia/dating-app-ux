import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout_shell.dart';
import '../../app/nav_shell.dart';
import '../../app/theme.dart';
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
        leading: BackTo(fallback: '/analyses/$analysisId'),
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
            // Every progress write re-runs `datesProvider`; without this the
            // whole body became a spinner ~7 times per run and every expanded
            // card collapsed (audit 2026-09-02).
            skipLoadingOnReload: true,
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

    if (!running && a.status != 'complete' && payload.dates.isEmpty) {
      // Reachable by URL or browser history for a `matched`, `matching`,
      // `no_candidates` or `failed` analysis: there are no results to
      // rank, and the masthead used to say "0 dates · No score" as if
      // that were one (audit 2026-09-02).
      return ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _Notice(
            title: 'No dates have run yet',
            body: a.status == 'matched'
                ? 'Your matches are ready. Open the analysis to start the dates.'
                : 'There are no results for this analysis. Open it to see where it stands.',
            onTap: () => context.go('/analyses/${a.id}'),
          ),
        ],
      );
    }

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

    // The masthead's right-hand tally, every number read off the wire rather
    // than asserted: candidates, dates, and how those dates ended.
    final complete = payload.dates.where((d) => d.status == 'complete').length;
    final partial = payload.dates
        .where((d) => d.evaluation?.isPartial == true || d.status == 'incomplete')
        .length;
    // The evening every candidate was run against, read off the wire rather
    // than inferred by comparing three `settingName` strings (2026-09-02).
    //
    // This block used to gather the distinct settings and, if there was more
    // than one, print "— the same for every candidate" under them. Under the
    // old per-candidate design that sentence was FALSE and the screen said it
    // anyway: three candidates had three different evenings and the masthead
    // claimed they had shared them. It is true now, and it is printed from
    // `payload.fixture`, which is the server stating it rather than the client
    // deducing it.
    final fixture = payload.fixture;
    final settings = <String>{
      for (final d in payload.dates)
        if (d.settingName.isNotEmpty) d.settingName,
    }.toList();
    final rubric = payload.dates
        .map((d) => d.evaluation?.rubricVersion ?? '')
        .firstWhere((v) => v.isNotEmpty, orElse: () => '');

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        if (running)
          _Notice(
            accent: true,
            title: 'Dates still running',
            body: a.progress?['message'] as String? ??
                'Scores arrive once every date has run.',
            leading: const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            onTap: () => context.go('/analyses/${a.id}'),
          )
        else if (judgingFailed || (a.status == 'complete' && notJudged))
          // Honest, not smoothed over (S13-U13): the dates ran, the scoring
          // did not. The transcripts are still the product.
          _Notice(
            accent: true,
            title: 'The dates ran, but scoring didn’t finish',
            body: a.progress?['message'] as String? ??
                'The transcripts are safe and you can read them.',
          ),
        if (a.removedCandidates > 0)
          _Notice(
            title: removedCandidatesSentence(a.removedCandidates),
            body: 'Their dates and scores went with them.',
          ),

        // ── The masthead ──────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Kicker('Analysis · ${a.status}', size: 12),
                    const SizedBox(height: 6),
                    Text('Ranking', style: theme.textTheme.headlineMedium),
                    if (fixture != null) ...[
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Tag('The same evening', filled: true),
                          Text(fixture.settingName,
                              style: theme.textTheme.titleSmall),
                          Text('— every candidate went here, so these scores '
                              'compare',
                              style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ] else if (settings.isNotEmpty) ...[
                      // An analysis from before the shared fixture: each date
                      // had its own setting, and the screen says exactly that
                      // rather than implying a comparison that was not made.
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Tag('Settings', filled: true),
                          for (final s in settings)
                            Text(s, style: theme.textTheme.titleSmall),
                          if (settings.length > 1)
                            Text('— a different one per candidate',
                                style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Kicker('${ranked.length} candidates · '
                      '${payload.dates.length} dates'),
                  Kicker('$complete complete · $partial partial'),
                  if (rubric.isNotEmpty) Kicker(rubric),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Scores come from four fixed checks on each date. Tap a score to '
            'see the checks.',
            style: theme.textTheme.bodySmall,
          ),
        ),
        const SizedBox(height: 16),

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
                style: theme.textTheme.bodyMedium),
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

/// A banner in the design's language: a flat tinted field under a 2px rule,
/// with no rounded card and no elevation to lift it off the page.
class _Notice extends StatelessWidget {
  const _Notice({
    required this.title,
    required this.body,
    this.accent = false,
    this.leading,
    this.onTap,
  });

  final String title;
  final String body;
  final bool accent;
  final Widget? leading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = Modernist.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        color: accent ? m.tint : m.plot,
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (leading != null) ...[
              Padding(padding: const EdgeInsets.only(top: 3), child: leading),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: theme.textTheme.titleSmall?.copyWith(
                          color: accent ? m.onTint : null)),
                  const SizedBox(height: 2),
                  Text(body,
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: accent ? m.onTint : null)),
                ],
              ),
            ),
          ],
        ),
      ),
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
    final m = Modernist.of(context);
    final anyPartial = judged.any((d) => d.evaluation!.isPartial);
    // The line under the big number, in the design's micro-label: what the
    // number is a mean OF, so the score is never a bare oracle.
    final scoreNote = judged.isEmpty
        ? ''
        : anyPartial
            ? '${judged.length} dates · '
                '${judged.where((d) => d.evaluation!.isPartial).length} partial ×$partialDateWeight'
            : 'mean of ${judged.length} '
                'date${judged.length == 1 ? '' : 's'}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Rule(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── The rank/score column: the design's 96px gutter, pulled
              // in on a phone so the sentences beside it keep a readable
              // measure ──────────────────────────────────────────────────
              SizedBox(
                width: MediaQuery.sizeOf(context).width < 480 ? 76 : 96,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.place}',
                        style: theme.textTheme.displayLarge?.copyWith(
                          height: 0.9,
                          color: widget.place == 1 ? m.you : m.muted,
                        )),
                    const SizedBox(height: 10),
                    if (score != null) ...[
                      const Kicker('Final'),
                      Text(score.toStringAsFixed(1),
                          style: theme.textTheme.displaySmall?.copyWith(
                            height: 1,
                            fontFeatures: const [
                              FontFeature.tabularFigures()
                            ],
                          )),
                      if (scoreNote.isNotEmpty) Kicker(scoreNote),
                      const SizedBox(height: 6),
                      // S13-U10: the score is a BUTTON. Tapping it shows the
                      // checks, and the arithmetic under them.
                      InkWell(
                        onTap: () => setState(
                            () => _showComposition = !_showComposition),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            _showComposition ? 'hide checks' : 'see checks',
                            style: theme.textTheme.labelSmall
                                ?.copyWith(color: m.you),
                          ),
                        ),
                      ),
                    ] else ...[
                      Text('No score',
                          style: theme.textTheme.titleSmall
                              ?.copyWith(color: m.muted)),
                      Kicker(widget.running ? 'not yet' : 'nothing to score'),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text('${c.displayName}, ${c.age}',
                            style: theme.textTheme.titleLarge),
                        DemoChip(isDemo: c.isDemo),
                      ],
                    ),
                    if (_showComposition && score != null) ...[
                      const SizedBox(height: 12),
                      _Composition(candidate: c, judged: judged),
                    ],
                    const SizedBox(height: 12),
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
            ],
          ),
        ),
      ],
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
    final m = Modernist.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      color: m.plot,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('The four checks, and their weights',
              style: theme.textTheme.titleSmall),
          const SizedBox(height: 4),
          Text(
            'These weights are our opinion of what matters on a date. They are '
            'the same for everyone and they are written down here so you can '
            'argue with them.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          // The design's weight bars: the criterion, its weight, and how this
          // candidate actually scored on it — the bar is the SCORE, the
          // number on the right is the weight, and both are labelled so
          // neither can be read as the other.
          for (final c in rubricWeights)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // The micro-label's weight and tracking, but NOT its
                      // uppercase: these four names are copy a person reads
                      // ("Didn’t clash"), and shouting them loses the
                      // apostrophe and the plain English with it.
                      Expanded(
                        child: Text(c.label,
                            style: theme.textTheme.labelSmall
                                ?.copyWith(fontSize: 11, color: m.them)),
                      ),
                      const SizedBox(width: 8),
                      Text('${(c.weight * 100).round()}%',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: m.muted,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          )),
                    ],
                  ),
                  const SizedBox(height: 4),
                  _WeightBar(value: _meanRaw(c), fill: m.you, ground: scheme.surface),
                  const SizedBox(height: 3),
                  Text(c.plain, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          const Rule(),
          const SizedBox(height: 8),
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

  /// The bar's length: this candidate's mean on one check across their judged
  /// dates, **as it counts** — the inverted check is shown the way it enters
  /// the sum (100 − clash), so a long bar always means "did well here" and
  /// the four bars can be read against each other.
  double _meanRaw(RubricCriterion c) {
    if (judged.isEmpty) return 0;
    var total = 0.0;
    for (final d in judged) {
      final raw = (d.evaluation!.criteria[c.key] as num? ?? 0).toDouble();
      total += c.inverted ? 100 - raw : raw;
    }
    return total / judged.length;
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

/// The design's 10px bar: a flat ground with a hard-edged fill, no radius, no
/// animation, no percentage printed inside it.
class _WeightBar extends StatelessWidget {
  const _WeightBar({required this.value, required this.fill, required this.ground});

  /// 0–100.
  final double value;
  final Color fill;
  final Color ground;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: LayoutBuilder(
        builder: (context, box) => Stack(
          children: [
            Container(width: box.maxWidth, height: 10, color: ground),
            Container(
              width: box.maxWidth * (value.clamp(0, 100) / 100),
              height: 10,
              color: fill,
            ),
          ],
        ),
      ),
    );
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

    final m = Modernist.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(border: Border.all(color: m.rule, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  d.settingName.isEmpty ? 'Date ${d.ordinal}' : d.settingName,
                  style: theme.textTheme.titleSmall,
                ),
              ),
              if (e != null && !d.excludedFromScore)
                Text(e.dateScore.toStringAsFixed(1),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontFeatures: const [FontFeature.tabularFigures()],
                    )),
            ],
          ),
          const SizedBox(height: 4),
          Text(endingSentence(status: d.status, endedBy: d.endedBy),
              style: theme.textTheme.bodySmall),
          // S13-U13: excluded / failed, with the reason, never smoothed over.
          //
          // REVISED 2026-09-02. This used to read "too short to judge — a date
          // needs 10 turns to be scored at all", which is the sentence the
          // owner removed the rule to stop showing. A short date is now judged
          // and its thinness is reported as the judge's confidence; the only
          // thing left in this branch is a date on which nobody spoke.
          if (d.excludedFromScore)
            _Note(
              tag: 'Not scored',
              colour: m.muted,
              text: d.status == 'failed'
                  ? 'Not scored — ${incompleteReason(d)}'
                  : 'Not scored — nothing was said. This date has no '
                      'conversation in it to read.',
            )
          // A finished date the server considers judgeable but that has no
          // evaluation stored. Reachable in bulk since 2026-09-02: dates
          // excluded under the old ten-turn rule were never judged, and
          // removing the rule made them judgeable without retroactively
          // judging them. Saying "scored from a partial date" about one would
          // be a claim that a score exists when none does (§10).
          else if (e == null &&
              (d.status == 'complete' || d.status == 'incomplete'))
            _Note(
              tag: 'Not yet scored',
              colour: m.muted,
              text: 'This date ran but has no score. It was skipped by the '
                  'old “too short to judge” rule, which no longer applies — '
                  're-running the analysis will score it.',
            )
          else if (d.status == 'incomplete')
            _Note(
              tag: 'Partial · weighted ×$partialDateWeight',
              colour: scheme.tertiary,
              text: '${incompleteReason(d)} Scored from a partial date — '
                  'weighted half.',
            )
          else if (d.status == 'running' || d.status == 'pending')
            _Note(
              tag: d.status == 'running' ? 'Running' : 'Queued',
              colour: m.muted,
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
                tag: 'Partial · weighted ×$partialDateWeight',
                colour: scheme.tertiary,
                text: 'Scored from a partial date — weighted half.',
              ),
            // How much the judge had to go on (2026-09-02). Shown BESIDE the
            // score and never folded into it: one number meaning both "how it
            // went" and "how much we saw" is a number nobody can read. Absent
            // on evaluations written under judge_rubric.v1, which were never
            // asked — and absence is rendered as absence, not as a zero.
            if (e.confidence != null) ...[
              const SizedBox(height: 10),
              _ConfidenceLine(
                confidence: e.confidence!,
                note: e.evidenceNote,
                turns: d.turnCount,
              ),
            ],
            const SizedBox(height: 10),
            if (e.verdictSummary.isNotEmpty)
              Text(e.verdictSummary, style: theme.textTheme.bodyMedium),
            if (e.clickedSubjects.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('What clicked', style: theme.textTheme.labelLarge),
              const SizedBox(height: 6),
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
            const SizedBox(height: 8),
            const Rule(),
            const SizedBox(height: 4),
            // A Wrap, not a Row: at phone width these two labels are wider
            // than the column the rank gutter leaves them, and a Row would
            // overflow rather than fold.
            Wrap(
              spacing: 8,
              children: [
                TextButton(
                  onPressed: () => setState(() => _showCurves = !_showCurves),
                  child: Text(
                      _showCurves ? 'Hide the curves' : 'How it felt, over time'),
                ),
                TextButton(
                  onPressed: () => context.push('/dates/${d.dateId}'),
                  child: const Text('Read it →'),
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

/// A caveat on a date, in the design's language: a square outlined tag naming
/// the state, then the sentence. The tag replaces the old icon — an icon can
/// only hint at "partial", where "PARTIAL · WEIGHTED ×0.5" says it.
/// How much the judge had to go on, in words and as a bar (2026-09-02).
///
/// This is the thing that replaced "not scored — too short to judge". The
/// score above it says how the evening went; this says how much evening there
/// was to read, and the two are deliberately never combined. A person looking
/// at 88 needs to be able to see whether it came from a full night or from
/// four polite lines, and no single number can tell them both.
///
/// The bar is drawn from the judge's own `confidence`, not from the turn
/// count: the turn count is how much was SAID and confidence is how much of it
/// was revealing, which are not the same thing. The turn count is shown beside
/// it as the check on that claim.
class _ConfidenceLine extends StatelessWidget {
  const _ConfidenceLine({
    required this.confidence,
    required this.note,
    required this.turns,
  });

  final int confidence;
  final String note;
  final int turns;

  /// Three bands, matching the three the server describes to the judge. Words
  /// rather than a bare percentage, because "how confident is 62" is a
  /// question a reader should not have to answer for themselves.
  String get _band {
    if (confidence >= 70) return 'Plenty to go on';
    if (confidence >= 40) return 'Something to go on';
    return 'Not much to go on';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = Modernist.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '$_band · $confidence/100 · $turns '
                'turn${turns == 1 ? '' : 's'} spoken',
                style: theme.textTheme.labelSmall?.copyWith(color: m.muted),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        // Deliberately not a progress indicator: this is not a thing filling
        // up, it is a reading with a width.
        LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Container(height: 3, width: constraints.maxWidth, color: m.rule),
              Container(
                height: 3,
                width: constraints.maxWidth * (confidence.clamp(0, 100) / 100),
                color: m.muted,
              ),
            ],
          ),
        ),
        if (note.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(note,
              style: theme.textTheme.bodySmall?.copyWith(color: m.muted)),
        ],
      ],
    );
  }
}

class _Note extends StatelessWidget {
  const _Note({required this.tag, required this.colour, required this.text});

  final String tag;
  final Color colour;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Tag(tag, colour: colour),
          const SizedBox(height: 4),
          Text(text, style: theme.textTheme.bodySmall?.copyWith(color: colour)),
        ],
      ),
    );
  }
}

/// A pill that wraps rather than a Chip that truncates (the Step 10 lesson).
/// Square, tinted from the accent ramp — the design's `#ffe0d9 / #7c1405`.
class _Pill extends StatelessWidget {
  const _Pill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = Modernist.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: m.tint,
      child: Text(text,
          style: theme.textTheme.bodySmall?.copyWith(
              color: m.onTint, fontWeight: FontWeight.w600)),
    );
  }
}

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    // Flush left, like every other block in this system — a centred column
    // would be the one place the grid stops.
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Kicker('Offline'),
          const SizedBox(height: 6),
          Text(message, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 16),
          FilledButton(onPressed: onRetry, child: const Text('Try again')),
        ],
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
      messenger.showSnackBar(SnackBar(content: Text('Something went wrong on this device. Please try again.')));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chosen = ref.watch(selectionForAnalysisProvider(widget.analysis.id));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Rule(),
        Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose one to talk to', style: theme.textTheme.titleMedium),
            const SizedBox(height: 6),
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
      ],
    );
  }
}
