import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout_shell.dart';
import '../../app/nav_shell.dart';
import '../../app/theme.dart';
import '../traits/traits_repository.dart';
import 'answer_flow.dart';
import 'models.dart';
import 'questions_providers.dart';

/// `/profile/correct/:questionId` — putting right a trait the AI got wrong
/// (S18-U3).
///
/// **The screen this replaces did not exist.** Disputing a trait created a
/// question and then sent the user to `/profile/expand`, which lists the
/// questions they have already ANSWERED so they can edit them. The new
/// question, being unanswered, appeared nowhere on it. The app said "added a
/// question so you can put it right" and then showed the user their five old
/// answers — which is what the report "I can't find it anywhere, and instead
/// it forces me to modify the 5 default questions" describes exactly.
///
/// So the correction gets its own screen, reached directly from the dispute,
/// and reachable again afterwards from the profile. One question, the trait it
/// is about stated above it, and nothing else on the page.
class CorrectionScreen extends ConsumerWidget {
  const CorrectionScreen({super.key, required this.questionId});

  final String questionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(questionsProvider);
    final traits = ref.watch(traitsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Put it right'),
        leading: const BackTo(fallback: '/profile'),
      ),
      body: LayoutShell(
        child: questions.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => _Missing(
            message: "Couldn't load the question.",
            onRetry: () => ref.invalidate(questionsProvider),
          ),
          data: (list) {
            final question =
                list.where((q) => q.id == questionId).firstOrNull;
            if (question == null) {
              return const _Missing(
                message: 'That correction is no longer here. It may have been '
                    'answered already, or the trait it was about is gone.',
              );
            }
            if (question.answered) {
              return _AlreadyAnswered(question: question);
            }
            final disputed = traits.valueOrNull?.traits
                .where((t) => t.status == 'disputed')
                .toList();
            // A Column with the flow in an Expanded, NOT a ListView wrapping
            // it: `AnswerFlow` is itself a ListView, and a scrollable inside a
            // scrollable has unbounded height.
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Kicker('Correcting the AI'),
                      const SizedBox(height: 8),
                      Text(
                        disputed != null && disputed.length == 1
                            ? 'You said “${disputed.first.label}” isn’t you.'
                            : 'You said one of these wasn’t you.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Answer this and the next rebuild of your profile will '
                        'use what you say here instead. Your other answers are '
                        'untouched.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const Rule(),
                // The SAME AnswerFlow every other question uses (§13/§16):
                // the difference is which question is passed in, never a
                // second implementation of answering.
                Expanded(
                  child: AnswerFlow(
                  key: ValueKey('correct-$questionId'),
                  questions: [question],
                  onFinished: () {
                    ref.invalidate(questionsProvider);
                    ref.invalidate(traitsProvider);
                    // The snackbar used to PROMISE a rebuild that nothing
                    // performed (audit 2026-09-02; the D-018 lesson again).
                    // Now the answer goes straight into a re-read, on the
                    // same building screen onboarding uses, and lands back
                    // on the profile with the correction applied.
                    GoRouter.of(context).go(
                        '/onboarding/building?to=${Uri.encodeComponent('/profile')}');
                  },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AlreadyAnswered extends StatelessWidget {
  const _AlreadyAnswered({required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Kicker('Already answered'),
        const SizedBox(height: 8),
        Text(question.text, style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        Text(question.answerText ?? '', style: theme.textTheme.bodyMedium),
        const SizedBox(height: 20),
        Text(
          'This correction is in. It will be used the next time your profile '
          'is rebuilt.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: () => context.go('/profile'),
          child: const Text('Back to your profile'),
        ),
      ],
    );
  }
}

class _Missing extends StatelessWidget {
  const _Missing({required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Kicker('Nothing to correct'),
          const SizedBox(height: 8),
          Text(message, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          if (onRetry != null)
            FilledButton(onPressed: onRetry, child: const Text('Try again'))
          else
            FilledButton(
              onPressed: () => context.go('/profile'),
              child: const Text('Back to your profile'),
            ),
        ],
      ),
    );
  }
}
