import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout_shell.dart';
import '../../core/api/api_client.dart';
import '../chat/chat_widget.dart';
import '../persona/persona_repository.dart';

/// `/profile/calibration` — "meet your AI self" (S8-U6).
///
/// Uses the SHARED chat widget with flagging ON. Step 14's match chat uses the
/// same widget with flagging OFF; the difference lives in [ChatConfig], not in
/// two copies of a chat screen (§13, §16).
///
/// **There is no "calibration mode" prompt** (AC5, named trade). The replies
/// come from the real snapshot through the real pipeline, so what you flag here
/// is exactly what a date agent would have said. A gentler calibration prompt
/// would make this screen pleasant and worthless.
class CalibrationScreen extends ConsumerStatefulWidget {
  const CalibrationScreen({super.key});

  @override
  ConsumerState<CalibrationScreen> createState() => _CalibrationScreenState();
}

class _CalibrationScreenState extends ConsumerState<CalibrationScreen> {
  final List<ChatBubble> _bubbles = [];
  String? _sessionId;
  String? _error;
  bool _starting = true;
  bool _sending = false;
  int _flagCount = 0;

  Dio get _dio => ref.read(apiClientProvider);

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    setState(() {
      _starting = true;
      _error = null;
    });
    try {
      final r = await _dio.post<Map<String, dynamic>>('/calibration/sessions');
      final counts =
          await _dio.get<Map<String, dynamic>>('/calibration/flags/count');
      if (!mounted) return;
      setState(() {
        _sessionId = r.data!['session_id'] as String;
        _flagCount = (counts.data!['flagged'] as num).toInt();
        _starting = false;
      });
    } on DioException catch (e) {
      final ex = ApiException.from(e);
      if (!mounted) return;
      setState(() {
        _error = ex.message;
        _starting = false;
      });
    }
  }

  Future<void> _send(String text) async {
    if (_sessionId == null) return;
    final tempId = 'local-${DateTime.now().microsecondsSinceEpoch}';
    setState(() {
      _bubbles.add(ChatBubble(id: tempId, text: text, fromMe: true));
      _sending = true;
    });
    try {
      final r = await _dio.post<Map<String, dynamic>>(
          '/calibration/sessions/$_sessionId/messages',
          data: {'text': text});
      if (!mounted) return;
      setState(() {
        _bubbles.add(ChatBubble(
          id: r.data!['message_id'] as String,
          text: r.data!['text'] as String,
          fromMe: false,
        ));
      });
    } on DioException catch (e) {
      final ex = ApiException.from(e);
      if (!mounted) return;
      // Every failure ends in something visible (D-005).
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(ex.message)));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _flag(String messageId, String? correction) async {
    final messenger = ScaffoldMessenger.of(context);
    final i = _bubbles.indexWhere((b) => b.id == messageId);
    if (i < 0) return;
    final previous = _bubbles[i];
    setState(() {
      _bubbles[i] = ChatBubble(
        id: previous.id, text: previous.text, fromMe: false, flagged: true,
      );
      _flagCount += 1;
    });
    try {
      await _dio.post<Map<String, dynamic>>(
          '/calibration/messages/$messageId/flag',
          data: {'correction': ?correction});
    } on DioException catch (e) {
      final ex = ApiException.from(e);
      if (!mounted) return;
      setState(() {
        _bubbles[i] = previous; // rollback
        _flagCount -= 1;
      });
      messenger.showSnackBar(SnackBar(content: Text(ex.message)));
    }
  }

  Future<void> _rebuild() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(personaRepositoryProvider).startCompile();
      ref.invalidate(personaProvider);
      messenger.showSnackBar(const SnackBar(
          content: Text('Rebuilding your AI self with your corrections…')));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your AI self'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/profile'),
        ),
      ),
      body: LayoutShell(
        child: _starting
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.forum_outlined, size: 48),
                          const SizedBox(height: 12),
                          Text(_error!, textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          FilledButton(
                              onPressed: _start, child: const Text('Try again')),
                          TextButton(
                            onPressed: () => context.go('/profile'),
                            child: const Text('Back to profile'),
                          ),
                        ],
                      ),
                    ),
                  )
                : ChatView(
                    bubbles: _bubbles,
                    sending: _sending,
                    inputHint: 'Say something to yourself…',
                    config: const ChatConfig(
                      // The two differences from match chat, stated here
                      // rather than assumed (§13).
                      allowFlagging: true,
                      showMetadata: false,
                    ),
                    onSend: _send,
                    onFlag: _flag,
                    banner: Container(
                      width: double.infinity,
                      color: theme.colorScheme.surfaceContainerHighest,
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'This is your AI double. Talk to it. If a line doesn’t '
                        'sound like you, long-press and flag it.',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    footer: _flagCount == 0
                        ? null
                        : Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.fromLTRB(12, 8, 12, 0),
                            child: Row(
                              children: [
                                Icon(Icons.flag,
                                    size: 16, color: theme.colorScheme.error),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    '$_flagCount correction'
                                    '${_flagCount == 1 ? '' : 's'} saved',
                                    style: theme.textTheme.labelMedium,
                                  ),
                                ),
                                TextButton(
                                  onPressed: _rebuild,
                                  child: const Text('Rebuild with these'),
                                ),
                              ],
                            ),
                          ),
                  ),
      ),
    );
  }
}
