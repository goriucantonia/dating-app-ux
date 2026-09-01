import 'package:flutter/material.dart';

/// THE shared chat widget (S8-U7), built once here and reused by match chat in
/// Step 14 (`chat_selection.md` decision 3, §16).
///
/// **The trap this config surface exists to prevent** (§13): calibration chat
/// and match chat share this widget BY DECISION but differ in their flagging
/// and metadata rules. Calibration is where you correct your own double, so
/// flagging is on; match chat is a conversation with another person's double,
/// where "I'd never say that" is meaningless and flagging their lines would be
/// bizarre. Those differences live in [ChatConfig] — passed in by the screen —
/// so neither chat can quietly inherit the other's behaviour by being edited
/// in the shared file.
class ChatConfig {
  const ChatConfig({
    required this.allowFlagging,
    required this.showMetadata,
    this.flagPrompt = "I'd never say that",
    this.correctionPrompt = 'What would you say instead? (optional)',
  });

  /// Long-press a reply to flag it. Calibration: true. Match chat: false.
  final bool allowFlagging;

  /// Show the agent's inner state (connection, satisfaction) beside replies.
  /// False in BOTH chats this phase — calibration deliberately hides it (the
  /// user is meeting their double, not reading its telemetry), and match chat
  /// must never show it: the server sends none. It exists because Step 13's
  /// date results do show it, through a different widget.
  final bool showMetadata;

  final String flagPrompt;
  final String correctionPrompt;
}

class ChatBubble {
  const ChatBubble({
    required this.id,
    required this.text,
    required this.fromMe,
    this.flagged = false,
    this.pending = false,
    this.isError = false,
  });

  final String id;
  final String text;

  /// True for the human's own messages. Named `fromMe` rather than `isUser`
  /// because in match chat BOTH sides are agents and "user" would be a lie.
  final bool fromMe;
  final bool flagged;
  final bool pending;

  /// An in-thread notice rather than a spoken line — the server's explicit
  /// "couldn't reply, try again" (S14-U6). Rendered centred, never as a
  /// bubble from either side, so it cannot be mistaken for something said.
  final bool isError;
}

class ChatView extends StatefulWidget {
  const ChatView({
    super.key,
    required this.bubbles,
    required this.config,
    required this.onSend,
    this.onFlag,
    this.sending = false,
    this.typingLabel,
    this.composerEnabled = true,
    this.banner,
    this.footer,
    this.inputHint = 'Say something…',
  });

  final List<ChatBubble> bubbles;
  final ChatConfig config;

  /// Sends the text. If it THROWS, the text is put back in the composer
  /// (S14-U6: user text is never dropped) and the error is rethrown to the
  /// caller's zone. Calibration catches its own failures and never throws;
  /// match chat throws on purpose so the composer keeps the message.
  final Future<void> Function(String text) onSend;

  /// Called with (bubbleId, correction). Required when [ChatConfig.allowFlagging].
  final Future<void> Function(String bubbleId, String? correction)? onFlag;

  final bool sending;

  /// When set and [sending] is true, a typing indicator carrying this label
  /// ("Dan is typing…") is drawn on the far side of the thread (S14-U6).
  final String? typingLabel;

  /// False for an ended chat: the history stays readable, the composer goes.
  final bool composerEnabled;

  final Widget? banner;
  final Widget? footer;
  final String inputHint;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();

  /// The last text whose send failed — shown as "unsent" under the composer
  /// until it goes through (S14-U6).
  String? _unsent;

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || widget.sending) return;
    _controller.clear();
    try {
      await widget.onSend(text);
      if (mounted) setState(() => _unsent = null);
    } catch (_) {
      // Put it back. The failure itself is the caller's to show.
      if (!mounted) return;
      setState(() {
        _controller.text = text;
        _unsent = text;
      });
      return;
    }
    if (!mounted) return;
    // After the reply lands, not before — otherwise it scrolls to where the
    // list used to end.
    if (_scroll.hasClients) {
      await _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _flag(ChatBubble b) async {
    if (!widget.config.allowFlagging || widget.onFlag == null) return;
    if (b.fromMe) return; // you cannot disown your own message
    final correction = await showDialog<String?>(
      context: context,
      builder: (ctx) => _FlagDialog(config: widget.config, original: b.text),
    );
    if (correction == null) return; // dismissed, not confirmed
    await widget.onFlag!(b.id, correction.isEmpty ? null : correction);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final typing = widget.sending && widget.typingLabel != null;
    return Column(
      children: [
        if (widget.banner != null) widget.banner!,
        Expanded(
          child: ListView.builder(
            controller: _scroll,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: widget.bubbles.length + (typing ? 1 : 0),
            itemBuilder: (context, i) {
              if (i == widget.bubbles.length) {
                return _TypingIndicator(label: widget.typingLabel!);
              }
              final b = widget.bubbles[i];
              if (b.isError) return _ErrorNotice(text: b.text);
              return _Bubble(
                bubble: b,
                config: widget.config,
                onLongPress: () => _flag(b),
              );
            },
          ),
        ),
        if (widget.footer != null) widget.footer!,
        if (widget.composerEnabled)
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_unsent != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 4),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline,
                              size: 14, color: theme.colorScheme.error),
                          const SizedBox(width: 4),
                          Text(
                            'Not sent yet — it’s still here, try again.',
                            style: theme.textTheme.labelSmall
                                ?.copyWith(color: theme.colorScheme.error),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          minLines: 1,
                          maxLines: 4,
                          // S14-U7: strictly sequential per session.
                          enabled: !widget.sending,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _send(),
                          decoration: InputDecoration(
                            hintText: widget.inputHint,
                            border: const OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filled(
                        onPressed: widget.sending ? null : _send,
                        icon: widget.sending
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Icon(_unsent != null ? Icons.refresh : Icons.send),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.bubble,
    required this.config,
    required this.onLongPress,
  });

  final ChatBubble bubble;
  final ChatConfig config;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mine = bubble.fromMe;
    final canFlag = config.allowFlagging && !mine;
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: canFlag ? onLongPress : null,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.78,
          ),
          decoration: BoxDecoration(
            color: mine
                ? theme.colorScheme.primaryContainer
                : theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
            border: bubble.flagged
                ? Border.all(color: theme.colorScheme.error, width: 1.5)
                : null,
          ),
          child: Column(
            crossAxisAlignment:
                mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Opacity(
                opacity: bubble.pending ? 0.6 : 1,
                child: Text(bubble.text, style: theme.textTheme.bodyLarge),
              ),
              if (bubble.flagged) ...[
                const SizedBox(height: 6),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.flag,
                        size: 14, color: theme.colorScheme.error),
                    const SizedBox(width: 4),
                    Text(
                      'Flagged — not you',
                      style: theme.textTheme.labelSmall
                          ?.copyWith(color: theme.colorScheme.error),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Reply latency as a typing indicator that resolves into the bubble
/// (S14-U6). Three dots, animated, on the far side.
class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator({required this.label});

  final String label;

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _c,
              builder: (_, _) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < 3; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Opacity(
                        opacity: ((_c.value * 3 - i) % 3).clamp(0.2, 1.0),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(widget.label, style: theme.textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}

/// The server's explicit "couldn't reply" as exactly that, in-thread.
class _ErrorNotice extends StatelessWidget {
  const _ErrorNotice({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline,
                size: 16, color: theme.colorScheme.onErrorContainer),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                text,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onErrorContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlagDialog extends StatefulWidget {
  const _FlagDialog({required this.config, required this.original});

  final ChatConfig config;
  final String original;

  @override
  State<_FlagDialog> createState() => _FlagDialogState();
}

class _FlagDialogState extends State<_FlagDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.config.flagPrompt),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('"${widget.original}"',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            minLines: 2,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: widget.config.correctionPrompt,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your corrections go into the next rebuild of your AI self.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_controller.text.trim()),
          child: const Text('Flag it'),
        ),
      ],
    );
  }
}
