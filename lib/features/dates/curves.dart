import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'models.dart';

/// One reading of one agent's inner state at one message (S13-U12).
class CurvePoint {
  const CurvePoint(this.seq, this.value);

  final int seq;
  final double value;
}

/// The four curves and the event markers, derived from a transcript by a
/// pure function so a test can check that every marker corresponds to an
/// actual `environment` row (AC7) without rendering a chart.
class CurveData {
  const CurveData({
    required this.userSatisfaction,
    required this.userConnection,
    required this.candidateSatisfaction,
    required this.candidateConnection,
    required this.eventSeqs,
    required this.maxSeq,
  });

  final List<CurvePoint> userSatisfaction;
  final List<CurvePoint> userConnection;
  final List<CurvePoint> candidateSatisfaction;
  final List<CurvePoint> candidateConnection;

  /// The `seq` of every environment row — one marker each, no more.
  final List<int> eventSeqs;
  final int maxSeq;

  bool get isEmpty =>
      userSatisfaction.isEmpty && candidateSatisfaction.isEmpty;
}

CurveData buildCurves(Transcript t) {
  final us = <CurvePoint>[], uc = <CurvePoint>[];
  final cs = <CurvePoint>[], cc = <CurvePoint>[];
  final events = <int>[];
  var maxSeq = 0;
  for (final m in t.messages) {
    if (m.seq > maxSeq) maxSeq = m.seq;
    if (m.speaker == 'environment') {
      events.add(m.seq);
      continue;
    }
    final state = m.state;
    // An agent row with no state is a gap, not a zero (S13-U13): it is left
    // out of the line rather than drawn as "felt nothing".
    if (state == null) continue;
    final sat = (state['satisfaction'] as num?)?.toDouble();
    final con = (state['connection'] as num?)?.toDouble();
    final mine = m.speaker == 'user_agent';
    if (sat != null) (mine ? us : cs).add(CurvePoint(m.seq, sat));
    if (con != null) (mine ? uc : cc).add(CurvePoint(m.seq, con));
  }
  return CurveData(
    userSatisfaction: us,
    userConnection: uc,
    candidateSatisfaction: cs,
    candidateConnection: cc,
    eventSeqs: events,
    maxSeq: maxSeq,
  );
}

/// The satisfaction/connection chart (S13-U12): both peers, both measures,
/// event markers on the timeline, scrub to a message, tap-through.
///
/// **Designed against real stored data, not the schema's 0–100 promise.** The
/// models use these two numbers unevenly — long stretches sit flat at 0 while
/// the transcript reads perfectly engaged, and then one turn jumps to 100.
/// The axis is fixed at 0–100 anyway, because rescaling would turn a flat
/// evening into a dramatic one; the caption under the chart says what the
/// numbers are.
class SatisfactionChart extends StatefulWidget {
  const SatisfactionChart({
    super.key,
    required this.transcript,
    required this.onOpenAt,
  });

  final Transcript transcript;

  /// Tap-through: open the transcript anchored at this `seq` (AC6).
  final void Function(int seq) onOpenAt;

  @override
  State<SatisfactionChart> createState() => _SatisfactionChartState();
}

class _SatisfactionChartState extends State<SatisfactionChart> {
  int? _scrubSeq;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final t = widget.transcript;
    final data = buildCurves(t);
    if (data.isEmpty) {
      return Text(
        'No inner-state readings were recorded for this date.',
        style: theme.textTheme.bodySmall,
      );
    }

    final me = t.userDisplayName;
    final them = t.candidateDisplayName;
    final userColour = scheme.primary;
    final candColour = scheme.tertiary;

    LineChartBarData line(List<CurvePoint> pts, Color colour, bool dashed) =>
        LineChartBarData(
          spots: [for (final p in pts) FlSpot(p.seq.toDouble(), p.value)],
          color: colour,
          barWidth: 2,
          isCurved: false,
          dotData: const FlDotData(show: false),
          dashArray: dashed ? [6, 4] : null,
        );

    final scrubbed = _scrubSeq == null
        ? null
        : t.messages.where((m) => m.seq == _scrubSeq).firstOrNull;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 4,
          children: [
            _Legend(colour: userColour, label: '$me — enjoying it'),
            _Legend(colour: userColour, label: '$me — feeling connected', dashed: true),
            _Legend(colour: candColour, label: '$them — enjoying it'),
            _Legend(colour: candColour, label: '$them — feeling connected', dashed: true),
            _Legend(colour: scheme.outline, label: 'something happened', marker: true),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              minX: 1,
              maxX: data.maxSeq.toDouble().clamp(2, double.infinity),
              minY: 0,
              maxY: 100,
              gridData: const FlGridData(show: true, drawVerticalLine: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,
                    interval: 50,
                    getTitlesWidget: (v, _) => Text('${v.round()}',
                        style: theme.textTheme.labelSmall),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 24,
                    interval: data.maxSeq > 12 ? 5 : 2,
                    getTitlesWidget: (v, _) => Text('${v.round()}',
                        style: theme.textTheme.labelSmall),
                  ),
                ),
              ),
              lineBarsData: [
                line(data.userSatisfaction, userColour, false),
                line(data.userConnection, userColour, true),
                line(data.candidateSatisfaction, candColour, false),
                line(data.candidateConnection, candColour, true),
              ],
              // AC7: one vertical marker per environment row, at its seq.
              extraLinesData: ExtraLinesData(
                verticalLines: [
                  for (final seq in data.eventSeqs)
                    VerticalLine(
                      x: seq.toDouble(),
                      color: scheme.outline,
                      strokeWidth: 1.5,
                      dashArray: [4, 4],
                    ),
                ],
              ),
              lineTouchData: LineTouchData(
                handleBuiltInTouches: true,
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (spots) => [
                    for (final s in spots)
                      LineTooltipItem(
                        '${s.y.round()}',
                        theme.textTheme.labelSmall!
                            .copyWith(color: s.bar.color),
                      ),
                  ],
                ),
                touchCallback: (event, response) {
                  final spot = response?.lineBarSpots?.firstOrNull;
                  if (spot == null) return;
                  final seq = spot.x.round();
                  if (seq != _scrubSeq) setState(() => _scrubSeq = seq);
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'What each AI reported feeling at that moment, 0–100. The models use '
          'these unevenly — they often sit at 0 while the conversation reads '
          'fine. The transcript is the real story; the marks show where '
          'something happened around them.',
          style: theme.textTheme.bodySmall,
        ),
        if (scrubbed != null) ...[
          const SizedBox(height: 8),
          _ScrubPreview(
            message: scrubbed,
            transcript: t,
            onOpen: () => widget.onOpenAt(scrubbed.seq),
          ),
        ] else ...[
          const SizedBox(height: 8),
          Text('Touch the chart to see the message at that point.',
              style: theme.textTheme.labelSmall),
        ],
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({
    required this.colour,
    required this.label,
    this.dashed = false,
    this.marker = false,
  });

  final Color colour;
  final String label;
  final bool dashed;
  final bool marker;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (marker)
          Container(width: 2, height: 12, color: colour)
        else
          SizedBox(
            width: 18,
            child: Divider(
              color: colour,
              thickness: 2,
              height: 2,
            ),
          ),
        const SizedBox(width: 4),
        Text(
          dashed ? '$label (dashed)' : label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}

/// "What happened at message 14?" — the answer, one tap from the curve
/// (simulation_results.md decision 3).
class _ScrubPreview extends StatelessWidget {
  const _ScrubPreview({
    required this.message,
    required this.transcript,
    required this.onOpen,
  });

  final TranscriptMessage message;
  final Transcript transcript;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final who = switch (message.speaker) {
      'user_agent' => transcript.userDisplayName,
      'candidate_agent' => transcript.candidateDisplayName,
      _ => 'Something happened',
    };
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Message ${message.seq} · $who',
              style: theme.textTheme.labelMedium),
          const SizedBox(height: 4),
          Text(message.reply,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onOpen,
              icon: const Icon(Icons.open_in_new, size: 16),
              label: Text('Open at message ${message.seq}'),
            ),
          ),
        ],
      ),
    );
  }
}
