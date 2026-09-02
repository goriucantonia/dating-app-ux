import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../app/theme.dart';
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
    final t = widget.transcript;
    final data = buildCurves(t);
    if (data.isEmpty) {
      return Text(
        'No inner-state readings were recorded for this date.',
        style: theme.textTheme.bodySmall,
      );
    }

    final mod = Modernist.of(context);
    final me = t.userDisplayName;
    final them = t.candidateDisplayName;
    // The design's two-stroke convention, and it is a convention worth
    // keeping: CONNECTION is the heavy solid line, SATISFACTION the light
    // dashed one, and the two people are told apart by colour, not by dash —
    // otherwise four dash patterns compete and none of them reads.
    final userColour = mod.you;
    final candColour = mod.them;

    LineChartBarData line(List<CurvePoint> pts, Color colour, bool dashed) =>
        LineChartBarData(
          spots: [for (final p in pts) FlSpot(p.seq.toDouble(), p.value)],
          color: colour,
          barWidth: dashed ? 1.5 : 2.5,
          isCurved: false,
          dotData: const FlDotData(show: false),
          dashArray: dashed ? [4, 3] : null,
        );

    final scrubbed = _scrubSeq == null
        ? null
        : t.messages.where((m) => m.seq == _scrubSeq).firstOrNull;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 6,
          children: [
            _Legend(colour: userColour, label: '$me · connected'),
            _Legend(colour: userColour, label: '$me · enjoying it', dashed: true),
            _Legend(colour: candColour, label: '$them · connected'),
            _Legend(colour: candColour, label: '$them · enjoying it', dashed: true),
            _Legend(colour: mod.muted, label: 'something happened', marker: true),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 200,
          color: mod.plot,
          padding: const EdgeInsets.only(top: 8, right: 8),
          child: LineChart(
            LineChartData(
              minX: 1,
              maxX: data.maxSeq.toDouble().clamp(2, double.infinity),
              minY: 0,
              maxY: 100,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 25,
                getDrawingHorizontalLine: (_) =>
                    FlLine(color: mod.gridline, strokeWidth: 1),
              ),
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
                line(data.userSatisfaction, userColour, true),
                line(data.userConnection, userColour, false),
                line(data.candidateSatisfaction, candColour, true),
                line(data.candidateConnection, candColour, false),
              ],
              // AC7: one vertical marker per environment row, at its seq.
              extraLinesData: ExtraLinesData(
                verticalLines: [
                  for (final seq in data.eventSeqs)
                    VerticalLine(
                      x: seq.toDouble(),
                      color: mod.them.withValues(alpha: 0.5),
                      strokeWidth: 1,
                      dashArray: [2, 3],
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
        const SizedBox(height: 6),
        // The design's axis strip: where the evening started, what is being
        // plotted, and where it ended — in the micro-label, under the plot.
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Kicker('Seq 1'),
            const Kicker('Connection · satisfaction · 0—100'),
            Kicker('Seq ${data.maxSeq}'),
          ],
        ),
        const SizedBox(height: 8),
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
        // The swatch draws the line it stands for: a dashed key for a dashed
        // curve, so the legend does not have to say "(dashed)" in words.
        if (marker)
          CustomPaint(
            size: const Size(1, 12),
            painter: _DashPainter(colour: colour, vertical: true),
          )
        else
          CustomPaint(
            size: Size(18, dashed ? 1.5 : 2.5),
            painter: _DashPainter(colour: colour, dashed: dashed),
          ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

/// The legend's key: a solid rule, a dashed rule, or the vertical dashed tick
/// an environment event is drawn with. Same dash pattern as the chart, so the
/// key and the curve are visibly the same stroke.
class _DashPainter extends CustomPainter {
  const _DashPainter({
    required this.colour,
    this.dashed = false,
    this.vertical = false,
  });

  final Color colour;
  final bool dashed;
  final bool vertical;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = colour
      ..strokeWidth = vertical ? 1 : size.height;
    final length = vertical ? size.height : size.width;
    if (!dashed && !vertical) {
      canvas.drawLine(Offset(0, size.height / 2),
          Offset(size.width, size.height / 2), paint);
      return;
    }
    const on = 4.0, off = 3.0;
    for (var pos = 0.0; pos < length; pos += on + off) {
      final end = (pos + on).clamp(0.0, length);
      canvas.drawLine(
        vertical ? Offset(size.width / 2, pos) : Offset(pos, size.height / 2),
        vertical ? Offset(size.width / 2, end) : Offset(end, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DashPainter old) =>
      old.colour != colour || old.dashed != dashed || old.vertical != vertical;
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
    final m = Modernist.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      color: m.plot,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Kicker('Message ${message.seq} · $who', size: 11),
          const SizedBox(height: 6),
          Text(message.reply,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium),
          const SizedBox(height: 4),
          TextButton(
            onPressed: onOpen,
            child: Text('Open at message ${message.seq} →'),
          ),
        ],
      ),
    );
  }
}
