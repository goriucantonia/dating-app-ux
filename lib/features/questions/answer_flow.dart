import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import 'models.dart';
import 'questions_repository.dart';

/// A2's voice nudge, shown under every answer field.
const voiceNudge =
    "Write at least 4–5 sentences, the way you'd actually say it. "
    'The AI learns your voice from how you write here.';

// Owner decision, 2026-09-01: lowered from 200. The server CHECK and the
// pydantic min_length move with it — this is the display half of one rule.
const _minChars = 50;

/// THE one-question-per-page answering widget (S5-U1/U2), used by onboarding,
/// pool expansion, and the single-answer editor — the same widget, the same
/// autosave, by decision (§16: not a second implementation).
///
/// Autosave fires on page advance AND on a 2-second idle debounce once the
/// answer passes 50 characters (under the minimum there is nothing the
/// server would accept). Named trade: a few extra PUTs beat a save button
/// users forget.
class AnswerFlow extends ConsumerStatefulWidget {
  const AnswerFlow({
    super.key,
    required this.questions,
    required this.onFinished,
    this.progressOffset = 0,
    this.progressTotal,
  });

  /// Questions to answer, in order. May be prefilled (editing).
  final List<Question> questions;

  /// Called after the last question's answer is saved.
  final VoidCallback onFinished;

  /// For "3 of 5" style labels when this flow is the tail of a larger set.
  final int progressOffset;
  final int? progressTotal;

  @override
  ConsumerState<AnswerFlow> createState() => _AnswerFlowState();
}

class _AnswerFlowState extends ConsumerState<AnswerFlow> {
  int _index = 0;
  late TextEditingController _controller;
  Timer? _debounce;
  String? _lastSaved;
  bool _saving = false;
  String? _serverError;

  Question get _question => widget.questions[_index];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _question.answerText ?? '');
    _lastSaved = _question.answerText;
    _controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged() {
    setState(() {}); // live character counter
    _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 2), () {
      if (_controller.text.length >= _minChars &&
          _controller.text != _lastSaved) {
        _save(_controller.text); // silent autosave; errors surface on advance
      }
    });
  }

  Future<bool> _save(String text) async {
    if (text == _lastSaved) return true;
    setState(() {
      _saving = true;
      _serverError = null;
    });
    try {
      await ref.read(questionsRepositoryProvider).saveAnswer(_question.id, text);
      _lastSaved = text;
      return true;
    } on ApiException catch (e) {
      setState(() => _serverError = e.message);
      return false;
    } catch (_) {
      setState(() => _serverError =
          'Something went wrong on this device. Please try again.');
      return false;
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _advance() async {
    _debounce?.cancel();
    if (!await _save(_controller.text)) return;
    if (_index + 1 < widget.questions.length) {
      setState(() {
        _index++;
        _controller.removeListener(_onChanged);
        _controller.dispose();
        _controller =
            TextEditingController(text: _question.answerText ?? '');
        _lastSaved = _question.answerText;
        _controller.addListener(_onChanged);
        _serverError = null;
      });
    } else {
      widget.onFinished();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final length = _controller.text.length;
    final enough = length >= _minChars;
    final total = widget.progressTotal ?? widget.questions.length;
    final position = widget.progressOffset + _index + 1;
    final isLast = _index + 1 >= widget.questions.length;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('$position of $total', style: theme.textTheme.labelLarge),
        const SizedBox(height: 12),
        Text(_question.text, style: theme.textTheme.titleLarge),
        const SizedBox(height: 16),
        TextField(
          controller: _controller,
          minLines: 8,
          maxLines: 16,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Write it the way you\'d say it out loud…',
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Text(voiceNudge, style: theme.textTheme.bodySmall),
            ),
            // Muted below the minimum, confirmed at 50 (S5-U1).
            Text(
              enough ? '$length / $_minChars ✓' : '$length / $_minChars',
              style: theme.textTheme.labelMedium!.copyWith(
                color: enough
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline,
                fontWeight: enough ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
        if (_serverError != null) ...[
          const SizedBox(height: 12),
          Text(_serverError!,
              style: TextStyle(color: theme.colorScheme.error)),
        ],
        const SizedBox(height: 20),
        Row(
          children: [
            FilledButton(
              onPressed: enough && !_saving ? _advance : null,
              child: _saving
                  ? const SizedBox(
                      height: 18, width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(isLast ? 'Finish' : 'Next'),
            ),
            const SizedBox(width: 16),
            if (!enough)
              Text('${_minChars - length} more characters',
                  style: theme.textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}
