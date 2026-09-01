import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout_shell.dart';
import '../../core/api/api_client.dart';
import '../common/demo_chip.dart';
import '../traits/models.dart' show traitCategoryLabels, traitCategoryOrder;
import 'chat_repository.dart';
import 'chat_widget.dart';
import 'models.dart';

/// `/chat/:sessionId` — the live conversation (S14-U4..U9).
///
/// The SHARED chat widget from Step 8, configured with flagging **off** and
/// metadata **off** — the two differences from calibration, stated here
/// rather than assumed (§13). The server sends no metadata on this path at
/// all, so "off" is the wire's truth, not a preference.
///
/// Header: the match's name plus a persistent, quiet "AI persona" tag —
/// immersive, never deceptive (named trade). Tapping it opens the sheet with
/// their trait labels, the date digest, and the way to the transcripts.
class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  ChatSessionDetail? _detail;
  final List<ChatBubble> _bubbles = [];
  String? _loadError;
  bool _loading = true;
  bool _sending = false;
  int _errorCounter = 0;

  ChatRepository get _repo => ref.read(chatRepositoryProvider);

  @override
  void initState() {
    super.initState();
    _load();
  }

  /// S14-U8: pages until the server says there is no more. Chats at this
  /// scale are small; loading the whole history is simpler than a scroll-up
  /// paginator and reads the same wire.
  Future<void> _load() async {
    setState(() {
      _loading = true;
      _loadError = null;
    });
    try {
      final detail = await _repo.detail(widget.sessionId);
      final all = <ChatMessageModel>[];
      var after = 0;
      while (true) {
        final page = await _repo.messages(widget.sessionId, afterSeq: after);
        all.addAll(page.messages);
        if (!page.hasMore) break;
        after = page.nextAfterSeq;
      }
      if (!mounted) return;
      setState(() {
        _detail = detail;
        _bubbles
          ..clear()
          ..addAll(all.map(_toBubble));
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadError = e is ApiException ? e.message : "Couldn't open this chat.";
        _loading = false;
      });
    }
  }

  ChatBubble _toBubble(ChatMessageModel m) => ChatBubble(
        id: m.messageId,
        text: m.text,
        fromMe: m.sender == 'user',
      );

  /// S14-U6/U7: the user bubble renders immediately; the persona side never
  /// optimistically. On failure the bubble is withdrawn, an in-thread notice
  /// says exactly what the server said, and the widget puts the text back in
  /// the composer (because this rethrows).
  Future<void> _send(String text) async {
    final tempId = 'local-${DateTime.now().microsecondsSinceEpoch}';
    setState(() {
      _bubbles.add(ChatBubble(id: tempId, text: text, fromMe: true, pending: true));
      _sending = true;
    });
    try {
      final result = await _repo.send(widget.sessionId, text);
      if (!mounted) return;
      setState(() {
        _bubbles.removeWhere((b) => b.id == tempId || b.isError);
        _bubbles
          ..add(_toBubble(result.userMessage))
          ..add(_toBubble(result.personaMessage));
        _sending = false;
      });
    } catch (e) {
      if (!mounted) rethrow;
      setState(() {
        _bubbles.removeWhere((b) => b.id == tempId || b.isError);
        _bubbles.add(ChatBubble(
          id: 'error-${_errorCounter++}',
          text: e is ApiException
              ? e.message
              : "That didn't send. Your message is still in the box.",
          fromMe: false,
          isError: true,
        ));
        _sending = false;
      });
      rethrow; // ChatView restores the composer text
    }
  }

  Future<void> _end() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('End this chat?'),
        content: const Text(
          'You can still read it afterwards, but you won’t be able to add to it.',
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Keep chatting')),
          FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('End chat')),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await _repo.end(widget.sessionId);
      ref.invalidate(chatSessionsProvider);
      if (!mounted) return;
      setState(() => _detail = _detail?.copyWith(status: 'ended'));
    } catch (e) {
      messenger.showSnackBar(SnackBar(
          content: Text(e is ApiException ? e.message : "Couldn't end the chat.")));
    }
  }

  void _openHeaderSheet() {
    final d = _detail;
    if (d == null) return;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _HeaderSheet(detail: d),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final d = _detail;
    final ended = d?.status == 'ended';
    final name = d?.match.displayName ?? 'Chat';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/chat'),
        ),
        title: InkWell(
          onTap: d == null ? null : _openHeaderSheet,
          child: Row(
            children: [
              Flexible(child: Text(name, overflow: TextOverflow.ellipsis)),
              DemoChip(isDemo: d?.match.isDemo ?? false, compact: true),
              const SizedBox(width: 8),
              // The persistent, quiet tag (S14-U5).
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outline),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('AI persona', style: theme.textTheme.labelSmall),
              ),
            ],
          ),
        ),
        actions: [
          // S14-U9: the navigation controls.
          PopupMenuButton<String>(
            onSelected: (v) => switch (v) {
              'end' => _end(),
              'profile' => context.go('/profile/expand'),
              'analysis' => context.go('/'),
              _ => null,
            },
            itemBuilder: (_) => [
              if (!ended)
                const PopupMenuItem(value: 'end', child: Text('End chat')),
              const PopupMenuItem(
                  value: 'profile', child: Text('Improve my profile')),
              const PopupMenuItem(
                  value: 'analysis', child: Text('Start a new analysis')),
            ],
          ),
        ],
      ),
      body: LayoutShell(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _loadError != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.forum_outlined, size: 48),
                          const SizedBox(height: 12),
                          Text(_loadError!, textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          FilledButton(
                              onPressed: _load, child: const Text('Try again')),
                        ],
                      ),
                    ),
                  )
                : ChatView(
                    bubbles: _bubbles,
                    sending: _sending,
                    typingLabel: '$name is typing…',
                    composerEnabled: !ended,
                    inputHint: 'Message $name…',
                    config: const ChatConfig(
                      // The two differences from calibration, stated (§13).
                      allowFlagging: false,
                      showMetadata: false,
                    ),
                    onSend: _send,
                    banner: ended
                        ? Container(
                            width: double.infinity,
                            color: theme.colorScheme.surfaceContainerHighest,
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'This chat has ended. You can still read it.',
                              style: theme.textTheme.bodySmall,
                            ),
                          )
                        : _bubbles.isEmpty
                            ? Container(
                                width: double.infinity,
                                color: theme.colorScheme.surfaceContainerHighest,
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  'This is an AI version of $name that remembers '
                                  'your simulated dates. $name isn’t here and '
                                  'won’t be told.',
                                  style: theme.textTheme.bodySmall,
                                ),
                              )
                            : null,
                  ),
      ),
    );
  }
}

/// S14-U5: their trait labels, the date digest, and a link to the original
/// transcripts. Labels only — the wire sends nothing else about them.
class _HeaderSheet extends StatelessWidget {
  const _HeaderSheet({required this.detail});

  final ChatSessionDetail detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final d = detail;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      builder: (ctx, controller) => ListView(
        controller: controller,
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Text(d.match.displayName, style: theme.textTheme.headlineSmall),
              DemoChip(isDemo: d.match.isDemo),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'An AI persona built from their own answers — the same one your '
            'simulated dates ran against.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          Text('What you two “did”', style: theme.textTheme.titleSmall),
          const SizedBox(height: 4),
          Text(d.dateDigest, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.push('/analyses/${d.analysisId}/results');
            },
            icon: const Icon(Icons.chat_bubble_outline),
            label: const Text('Read the original transcripts'),
          ),
          const SizedBox(height: 12),
          Text('Their traits', style: theme.textTheme.titleSmall),
          if (d.traitLabels.isEmpty)
            Text('No traits to show.', style: theme.textTheme.bodySmall),
          for (final category in traitCategoryOrder)
            if ((d.traitLabels[category] ?? const []).isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Text(traitCategoryLabels[category] ?? category,
                    style: theme.textTheme.labelLarge),
              ),
              for (final l in d.traitLabels[category]!)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(l, style: theme.textTheme.bodyMedium),
                ),
            ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
