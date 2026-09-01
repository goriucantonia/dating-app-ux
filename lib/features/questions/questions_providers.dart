import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth/auth_controller.dart';
import 'models.dart';
import 'questions_repository.dart';

/// Everything answerable by the signed-in user, with answered state — the
/// payload behind resume, the onboarding guard, pool progress, and the edit
/// list. Empty while signed out; rebuilds on login/logout.
class QuestionsController extends AsyncNotifier<List<Question>> {
  @override
  Future<List<Question>> build() async {
    final user = ref.watch(authControllerProvider).valueOrNull;
    if (user == null) return const [];
    return ref.read(questionsRepositoryProvider).fetchAll();
  }
}

final questionsProvider =
    AsyncNotifierProvider<QuestionsController, List<Question>>(
        QuestionsController.new);

/// The "nothing works without it" gate's condition (ux_architecture.md §1.2):
/// null = not known yet (loading/signed out), true = has unanswered baseline.
bool? baselineIncomplete(AsyncValue<List<Question>> questions) {
  final list = questions.valueOrNull;
  if (list == null || list.isEmpty) return null;
  return list.any((q) => q.origin == 'baseline' && !q.answered);
}
