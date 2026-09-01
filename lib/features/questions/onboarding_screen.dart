import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout_shell.dart';
import 'answer_flow.dart';
import 'questions_providers.dart';

/// `/onboarding/questions` — BQ1..BQ5 one per page with autosave (S5-U1..U4).
/// Resume comes free: GET /questions drives "first unanswered question".
class OnboardingQuestionsScreen extends ConsumerStatefulWidget {
  const OnboardingQuestionsScreen({super.key});

  @override
  ConsumerState<OnboardingQuestionsScreen> createState() =>
      _OnboardingQuestionsScreenState();
}

class _OnboardingQuestionsScreenState
    extends ConsumerState<OnboardingQuestionsScreen> {
  bool _pastInterstitial = false;

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(questionsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Your 5 questions')),
      body: LayoutShell(
        child: questions.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => _ErrorRetry(
            onRetry: () => ref.invalidate(questionsProvider),
          ),
          data: (list) {
            final baseline = list.where((q) => q.origin == 'baseline').toList()
              ..sort((a, b) => (a.code ?? '').compareTo(b.code ?? ''));
            final unanswered = baseline.where((q) => !q.answered).toList();
            if (unanswered.isEmpty) {
              // Guard flips to '/' once the provider refreshes.
              return const Center(child: CircularProgressIndicator());
            }
            final answeredCount = baseline.length - unanswered.length;
            // The interstitial states the deal plainly, once, before question
            // one (S5-U4). A returning user resumes straight into the flow.
            if (answeredCount == 0 && !_pastInterstitial) {
              return _Interstitial(
                  onStart: () => setState(() => _pastInterstitial = true));
            }
            return AnswerFlow(
              // Key by first unanswered question so finishing one rebuilds
              // cleanly when the provider refreshes behind us.
              key: ValueKey(unanswered.first.id),
              questions: unanswered,
              progressOffset: answeredCount,
              progressTotal: baseline.length,
              // S7-U1: the last answer hands straight over to the
              // extract -> compile chain rather than dropping the user on a
              // home screen that has nothing for them yet.
              onFinished: () {
                ref.invalidate(questionsProvider);
                context.go('/onboarding/building');
              },
            );
          },
        ),
      ),
    );
  }
}

class _Interstitial extends StatelessWidget {
  const _Interstitial({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit_note, size: 56, color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              '5 questions, about 10 minutes.',
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Write like you talk — the AI learns your voice from this. '
              'Nothing works without it.',
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: onStart, child: const Text('Start')),
          ],
        ),
      ),
    );
  }
}

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off, size: 48),
          const SizedBox(height: 12),
          const Text("Couldn't load your questions."),
          const SizedBox(height: 12),
          FilledButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
    );
  }
}
