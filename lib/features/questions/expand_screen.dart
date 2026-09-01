import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/layout_shell.dart';
import '../../core/api/api_client.dart';
import 'answer_flow.dart';
import 'models.dart';
import 'questions_providers.dart';
import 'questions_repository.dart';

/// `/profile/expand` (S5-U5..U7): "Answer 5 more questions" with pool
/// progress, the exhausted achievement state, and editing past answers —
/// all through the SAME AnswerFlow widget as onboarding (§16).
class ExpandScreen extends ConsumerStatefulWidget {
  const ExpandScreen({super.key});

  @override
  ConsumerState<ExpandScreen> createState() => _ExpandScreenState();
}

class _ExpandScreenState extends ConsumerState<ExpandScreen> {
  List<Question>? _activeBatch;
  Question? _editing;
  bool _loadingBatch = false;
  String? _error;

  Future<void> _startBatch() async {
    setState(() {
      _loadingBatch = true;
      _error = null;
    });
    try {
      final batch = await ref.read(questionsRepositoryProvider).nextBatch();
      if (!mounted) return;
      setState(() => _activeBatch = batch.questions);
    } on ApiException catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      setState(() =>
          _error = 'Something went wrong on this device. Please try again.');
    } finally {
      if (mounted) setState(() => _loadingBatch = false);
    }
  }

  void _doneWithFlow() {
    setState(() {
      _activeBatch = null;
      _editing = null;
    });
    ref.invalidate(questionsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final questions = ref.watch(questionsProvider);

    Widget body;
    if (_editing != null) {
      body = AnswerFlow(
        key: ValueKey('edit-${_editing!.id}'),
        questions: [_editing!],
        onFinished: _doneWithFlow,
      );
    } else if (_activeBatch != null) {
      body = AnswerFlow(
        key: ValueKey('batch-${_activeBatch!.first.id}'),
        questions: _activeBatch!,
        onFinished: _doneWithFlow,
      );
    } else {
      body = questions.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.cloud_off, size: 48),
            const SizedBox(height: 12),
            const Text("Couldn't load your answers."),
            const SizedBox(height: 12),
            FilledButton(
                onPressed: () => ref.invalidate(questionsProvider),
                child: const Text('Try again')),
          ]),
        ),
        data: (list) {
          final pool = list.where((q) => q.origin == 'pool').toList();
          final answeredPool = pool.where((q) => q.answered).length;
          final exhausted = pool.isNotEmpty && answeredPool == pool.length;
          final answered = list.where((q) => q.answered).toList();
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              if (exhausted)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      Icon(Icons.emoji_events,
                          size: 44, color: theme.colorScheme.primary),
                      const SizedBox(height: 8),
                      Text(
                        "You've answered everything — your profile is as deep "
                        'as it gets for now. Keep it sharp by editing old '
                        'answers.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium,
                      ),
                    ]),
                  ),
                )
              else ...[
                Text('$answeredPool of ${pool.length} answered',
                    style: theme.textTheme.labelLarge),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: _loadingBatch ? null : _startBatch,
                  icon: const Icon(Icons.add_comment),
                  label: Text(_loadingBatch
                      ? 'Loading…'
                      : 'Answer 5 more questions'),
                ),
              ],
              if (_error != null) ...[
                const SizedBox(height: 8),
                Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
              ],
              const SizedBox(height: 24),
              Text('Your answers', style: theme.textTheme.titleMedium),
              Text(
                'Editing changes your future matches, not past results.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              if (answered.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Nothing answered yet.'),
                )
              else
                for (final q in answered)
                  Card(
                    child: ListTile(
                      title: Text(q.text,
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      subtitle: Text(q.answerText ?? '',
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      trailing: const Icon(Icons.edit_outlined),
                      onTap: () => setState(() => _editing = q),
                    ),
                  ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Deepen your profile')),
      body: LayoutShell(child: body),
    );
  }
}
