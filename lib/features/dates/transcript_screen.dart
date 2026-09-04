import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/layout_shell.dart';
import '../../app/nav_shell.dart';
import '../../core/api/api_client.dart';
import '../../core/polling/poller.dart';
import 'dates_repository.dart';
import 'metadata_toggle.dart';
import 'models.dart';

/// `/dates/:id` — the transcript viewer (S13-U6..U9, U14).
///
/// Your agent on the right, theirs on the left, environment events as
/// centred context blocks. The metadata toggle in the app bar is the global
/// one; on, every spoken bubble grows a badge row with the agent's inner
/// state — the deliberate exposure the transcript endpoint exists for
/// (decision log #4). Off is a clean read.
///
/// `?seq=N` anchors the view on message N and outlines it, which is what the
/// results chart's tap-through lands on (S13-U9, AC6).
class TranscriptScreen extends ConsumerStatefulWidget {
  const TranscriptScreen({super.key, required this.dateId, this.anchorSeq});

  final String dateId;
  final int? anchorSeq;

  @override
  ConsumerState<TranscriptScreen> createState() => _TranscriptScreenState();
}

class _TranscriptScreenState extends ConsumerState<TranscriptScreen> {
  final _keys = <int, GlobalKey>{};
  bool _anchored = false;

  GlobalKey _keyFor(int seq) => _keys.putIfAbsent(seq, GlobalKey.new);

  void _scrollToAnchor() {
    final seq = widget.anchorSeq;
    if (seq == null || _anchored) return;
    final ctx = _keys[seq]?.currentContext;
    if (ctx == null) return;
    _anchored = true;
    Scrollable.ensureVisible(
      ctx,
      alignment: 0.2,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    final transcript = ref.watch(transcriptProvider(widget.dateId));
    final showMeta = ref.watch(metadataToggleProvider).valueOrNull ?? true;
    return Scaffold(
      appBar: AppBar(
        title: Text(transcript.valueOrNull?.settingName ?? 'The date'),
        leading: BackTo(
          fallback: transcript.valueOrNull == null
              ? '/'
              : '/analyses/${transcript.valueOrNull!.analysisId}',
        ),
        actions: [
          // S13-U7: the ONE global switch. Persisted per user; both settings
          // are observed doing different things (§8).
          Row(
            children: [
              Text('Inner state',
                  style: Theme.of(context).textTheme.labelMedium),
              Switch(
                value: showMeta,
                onChanged: (v) =>
                    ref.read(metadataToggleProvider.notifier).set(v),
              ),
            ],
          ),
        ],
      ),
      body: LayoutShell(
        child: transcript.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => (e is ApiException && e.status == 404)
              // S15-U2 shape, as the chat screen already has it: a date that
              // is gone went with the person it was with. No retry can
              // bring it back.
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'This date is no longer here — the person it was with '
                      'has left.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : _ErrorRetry(
                  message: e is ApiException ? e.message : "Couldn't load this date.",
                  onRetry: () => ref.invalidate(transcriptProvider(widget.dateId)),
                ),
          data: (t) {
            WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToAnchor());
            return _Body(
              transcript: t,
              showMeta: showMeta,
              keyFor: _keyFor,
              anchorSeq: widget.anchorSeq,
              onRefresh: () => ref.invalidate(transcriptProvider(widget.dateId)),
            );
          },
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({
    required this.transcript,
    required this.showMeta,
    required this.keyFor,
    required this.anchorSeq,
    required this.onRefresh,
  });

  final Transcript transcript;
  final bool showMeta;
  final GlobalKey Function(int seq) keyFor;
  final int? anchorSeq;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final t = transcript;
    // The SAME poller the dashboard and the analysis screen watch (§16), so
    // "other dates are still running" is the server's word, not a guess.
    final analysisStatus =
        ref.watch(analysisPollerProvider(t.analysisId)).valueOrNull?.status;
    final stillRunning = analysisStatus == 'simulating';

    // A plain scroll view, NOT a lazy ListView: `?seq=` needs message N to
    // be built before it can be scrolled to, and a transcript is at most 19
    // rows (TURN_CAP + MAX_EVENTS_PER_DATE) — laziness buys nothing here and
    // costs the anchor.
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        if (stillRunning)
          // S13-U14: same widgets, partial data, honestly framed.
          Card(
            color: theme.colorScheme.tertiaryContainer,
            child: ListTile(
              leading: const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              title: Text(
                t.status == 'running'
                    ? 'This date is still going'
                    : 'Other dates are still running',
                style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
              ),
              subtitle: Text(
                t.status == 'running'
                    ? 'What you see is what has been said so far.'
                    : 'This one is finished. Scores arrive when all of them are.',
                style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
              ),
              trailing: t.status == 'running'
                  ? IconButton(
                      tooltip: 'Refresh',
                      icon: const Icon(Icons.refresh),
                      onPressed: onRefresh,
                    )
                  : null,
            ),
          ),
        _SettingCard(transcript: t),
        const SizedBox(height: 8),
        if (t.messages.isEmpty)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              t.status == 'running' || t.status == 'pending'
                  ? 'Nothing has been said yet.'
                  : 'No messages were recorded for this date.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        for (final m in t.messages)
          KeyedSubtree(
            key: keyFor(m.seq),
            child: m.speaker == 'environment'
                ? _EventBlock(message: m, anchored: m.seq == anchorSeq)
                : _Bubble(
                    message: m,
                    transcript: t,
                    showMeta: showMeta,
                    anchored: m.seq == anchorSeq,
                  ),
          ),
        const SizedBox(height: 12),
        _EndingFooter(transcript: t),
        ],
      ),
    );
  }
}

class _SettingCard extends StatelessWidget {
  const _SettingCard({required this.transcript});

  final Transcript transcript;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = transcript;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${t.userDisplayName} and ${t.candidateDisplayName}',
              style: theme.textTheme.labelLarge,
            ),
            const SizedBox(height: 6),
            Text(t.description, style: theme.textTheme.bodyMedium),
            if (t.sensoryDetails.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                t.sensoryDetails,
                style: theme.textTheme.bodySmall
                    ?.copyWith(fontStyle: FontStyle.italic),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.message,
    required this.transcript,
    required this.showMeta,
    required this.anchored,
  });

  final TranscriptMessage message;
  final Transcript transcript;
  final bool showMeta;
  final bool anchored;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final mine = message.speaker == 'user_agent';
    final name =
        mine ? transcript.userDisplayName : transcript.candidateDisplayName;
    final state = message.state;
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        key: ValueKey('bubble-${message.seq}'),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.8,
        ),
        decoration: BoxDecoration(
          color: mine ? scheme.primaryContainer : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
          border: anchored
              ? Border.all(color: scheme.primary, width: 2)
              : null,
        ),
        child: Column(
          crossAxisAlignment:
              mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              '$name · ${message.seq}',
              style: theme.textTheme.labelSmall,
            ),
            const SizedBox(height: 2),
            Text(message.reply, style: theme.textTheme.bodyLarge),
            if (showMeta && state != null) ...[
              const SizedBox(height: 8),
              _StateBadges(state: state, alignEnd: mine),
            ],
          ],
        ),
      ),
    );
  }
}

/// The badge row (S13-U7): emotional state, state of mind, connection %,
/// satisfaction %. Rendered only when the toggle is on AND the row has state;
/// absent state is shown as nothing, never as zeros (S13-U13).
class _StateBadges extends StatelessWidget {
  const _StateBadges({required this.state, required this.alignEnd});

  final Map<String, dynamic> state;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final emotion = state['emotional_state'] as String?;
    final mind = state['state_of_mind'] as String?;
    final connection = state['connection'] as num?;
    final satisfaction = state['satisfaction'] as num?;
    final wantsToEnd = state['wants_to_end'] == true;

    Widget pill(String text, {IconData? icon}) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 12, color: scheme.onSurfaceVariant),
                const SizedBox(width: 3),
              ],
              Text(text, style: theme.textTheme.labelSmall),
            ],
          ),
        );

    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 6,
          runSpacing: 4,
          alignment: alignEnd ? WrapAlignment.end : WrapAlignment.start,
          children: [
            if (emotion != null && emotion.isNotEmpty)
              pill(emotion, icon: Icons.mood),
            if (connection != null)
              pill('connection ${connection.round()}%', icon: Icons.link),
            if (satisfaction != null)
              pill('enjoying ${satisfaction.round()}%', icon: Icons.thumb_up_alt_outlined),
            if (wantsToEnd) pill('ready to wrap up', icon: Icons.logout),
          ],
        ),
        if (mind != null && mind.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            'thinking: $mind',
            style: theme.textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
              color: scheme.onSurfaceVariant,
            ),
            textAlign: alignEnd ? TextAlign.end : TextAlign.start,
          ),
        ],
      ],
    );
  }
}

/// An environment event as a centred context block (S13-U6).
class _EventBlock extends StatelessWidget {
  const _EventBlock({required this.message, required this.anchored});

  final TranscriptMessage message;
  final bool anchored;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Center(
      child: Container(
        key: ValueKey('event-${message.seq}'),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.85,
        ),
        decoration: BoxDecoration(
          color: scheme.tertiaryContainer.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: anchored ? scheme.primary : scheme.outlineVariant,
            width: anchored ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🌩', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                message.reply,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: scheme.onTertiaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// S13-U8: how it ended, in the server's words.
class _EndingFooter extends StatelessWidget {
  const _EndingFooter({required this.transcript});

  final Transcript transcript;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = transcript;
    final sentence = endingSentence(status: t.status, endedBy: t.endedBy);
    final (IconData icon, Color colour) = switch (t.status) {
      'complete' => (Icons.nightlight_round, theme.colorScheme.primary),
      'incomplete' => (Icons.warning_amber_rounded, theme.colorScheme.tertiary),
      'failed' => (Icons.error_outline, theme.colorScheme.error),
      _ => (Icons.more_horiz, theme.colorScheme.outline),
    };
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 8),
        Icon(icon, color: colour),
        const SizedBox(height: 6),
        Text(sentence,
            textAlign: TextAlign.center, style: theme.textTheme.titleSmall),
        if (t.status == 'incomplete')
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'The rest of the evening never happened — the AI stopped '
              'answering. Everything above is real.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
          ),
      ],
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
