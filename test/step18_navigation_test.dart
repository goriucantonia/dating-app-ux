/// Step 18 widget tests — the persistent navigation and the correction flow,
/// driven through the REAL `routerProvider` so the shell itself is under test.
///
/// These exist because of two reports from use: "after clicking on Profile, I
/// cannot easily go back to start a new analysis", and "when I click do not
/// confirm it says a new question has been added, but I can't find it
/// anywhere, and instead it forces me to modify the 5 default questions I
/// already have."
library;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dating_app_ux/app/nav_shell.dart';
import 'package:dating_app_ux/app/router.dart';
import 'package:dating_app_ux/core/auth/auth_controller.dart';
import 'package:dating_app_ux/features/analyses/analyses_repository.dart';
import 'package:dating_app_ux/features/analyses/models.dart';
import 'package:dating_app_ux/features/auth/models.dart';
import 'package:dating_app_ux/features/persona/models.dart';
import 'package:dating_app_ux/features/persona/persona_repository.dart';
import 'package:dating_app_ux/features/questions/models.dart';
import 'package:dating_app_ux/features/questions/questions_providers.dart';
import 'package:dating_app_ux/features/questions/questions_repository.dart';
import 'package:dating_app_ux/features/traits/models.dart';
import 'package:dating_app_ux/features/traits/traits_repository.dart';

const _me = User(
  id: 'u1',
  email: 'me@example.com',
  displayName: 'Ana',
  birthDate: '1996-04-18',
  age: 30,
  gender: 'woman',
  interestedIn: ['man'],
  agePrefMin: 24,
  agePrefMax: 45,
  optIn: true,
  isDemo: false,
);

const _trait = Trait(
  id: 't1',
  category: 'behavioral',
  label: 'avoidant when disappointed',
  description: 'Goes quiet rather than saying the thing.',
  confidence: 0.7,
  status: 'inferred',
  sourceAnswerIds: ['a1'],
  extractedBy: 'openrouter/model',
);

Question _q(String id, String origin, {bool answered = true, String? text}) =>
    Question(
      id: id,
      origin: origin,
      code: origin == 'baseline' ? 'BQ1' : null,
      probeArea: 'situational',
      text: text ?? 'A baseline question you already answered',
      answered: answered,
      answerText: answered ? 'Something I already wrote, at length.' : null,
    );

/// The five answered baseline questions the old flow used to dump the user in
/// front of, plus (optionally) the unanswered dispute question.
List<Question> _questions({Question? dispute}) => [
      for (var i = 1; i <= 5; i++) _q('b$i', 'baseline'),
      ?dispute,
    ];

final _correction = _q(
  'q-dispute',
  'dispute',
  answered: false,
  text: 'When have you actually said the difficult thing out loud?',
);

class _SignedIn extends AuthController {
  @override
  Future<User?> build() async => _me;
}

/// The server's question list, shared by the fakes so a dispute actually adds
/// a question the way the real API does — otherwise the test would prove the
/// screen renders a question that the app could never have fetched.
class _Store {
  _Store(this.rows);

  final List<Question> rows;
}

class _Questions extends QuestionsController {
  _Questions(this.store);

  final _Store store;

  @override
  Future<List<Question>> build() async => List.of(store.rows);
}

class _FakeTraits extends TraitsRepository {
  _FakeTraits(this.store) : super(Dio());

  final _Store store;
  int disputes = 0;

  @override
  Future<TraitsPayload> fetch() async =>
      const TraitsPayload(traits: [_trait], traitsHash: 'h1');

  @override
  Future<DisputeResult> dispute(String traitId, {String? correction}) async {
    disputes++;
    // Exactly what POST /traits/{id}/dispute does: the question now exists.
    store.rows.add(_correction);
    return DisputeResult(
      trait: _trait.copyWith(status: 'disputed'),
      questionId: _correction.id,
      questionText: _correction.text,
    );
  }
}

class _FakePersona extends PersonaRepository {
  _FakePersona() : super(Dio());

  @override
  Future<PersonaState> current() async => const PersonaState(
        snapshot: PersonaSnapshot(
          snapshotId: 's1',
          version: 1,
          status: 'ready',
          schemaVersion: 'persona.v1',
          traitsHash: 'h1',
          sourceTraitCount: 1,
        ),
        simulatable: true,
      );
}

class _FakeAnalyses extends AnalysesRepository {
  _FakeAnalyses() : super(Dio());

  @override
  Future<List<Analysis>> history() async => [];
}

class _FakeQuestionsRepo extends QuestionsRepository {
  _FakeQuestionsRepo() : super(Dio());
}

Future<ProviderContainer> _pump(
  WidgetTester tester, {
  List<Question>? questions,
  _FakeTraits? traits,
  _Store? store,
}) async {
  final shared = store ?? _Store([...(questions ?? _questions())]);
  tester.view.physicalSize = const Size(820, 2200);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final container = ProviderContainer(overrides: [
    authControllerProvider.overrideWith(_SignedIn.new),
    questionsProvider.overrideWith(() => _Questions(shared)),
    traitsRepositoryProvider.overrideWithValue(traits ?? _FakeTraits(shared)),
    personaRepositoryProvider.overrideWithValue(_FakePersona()),
    analysesRepositoryProvider.overrideWithValue(_FakeAnalyses()),
    questionsRepositoryProvider.overrideWithValue(_FakeQuestionsRepo()),
  ]);
  addTearDown(container.dispose);
  await tester.pumpWidget(UncontrolledProviderScope(
    container: container,
    child: Consumer(
      builder: (context, ref, _) =>
          MaterialApp.router(routerConfig: ref.watch(routerProvider)),
    ),
  ));
  await tester.pumpAndSettle();
  return container;
}

void main() {
  testWidgets('the navigation is present and names all four destinations',
      (tester) async {
    await _pump(tester);
    expect(find.byType(NavShell), findsOneWidget);
    for (final d in NavShell.destinations) {
      expect(find.text(d.label), findsWidgets, reason: d.label);
    }
  });

  testWidgets('from Profile, Home is one tap away — the original report',
      (tester) async {
    await _pump(tester);
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Your profile'), findsOneWidget);

    // The whole complaint: getting back to where an analysis starts.
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.text('Dating App AI'), findsOneWidget);
  });

  testWidgets('a screen under a tab keeps the bar and can come back',
      (tester) async {
    await _pump(tester);
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Answer more questions'));
    await tester.pumpAndSettle();
    expect(find.text('Deepen your profile'), findsOneWidget);
    // Still navigable — the bar does not vanish under a sub-screen.
    expect(find.byType(NavShell), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Your profile'), findsOneWidget);
  });

  testWidgets('each tab keeps its own place', (tester) async {
    await _pump(tester);
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Answer more questions'));
    await tester.pumpAndSettle();
    expect(find.text('Deepen your profile'), findsOneWidget);

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.text('Dating App AI'), findsOneWidget);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    // Back where it was left, not reset to the tab root.
    expect(find.text('Deepen your profile'), findsOneWidget);
  });

  // ---------------------------------------------------------------------
  // The correction flow
  // ---------------------------------------------------------------------

  testWidgets('disputing a trait leads straight to ITS question, not to the '
      'list of answers you already wrote', (tester) async {
    final store = _Store([..._questions()]);
    final traits = _FakeTraits(store);
    await _pump(tester, store: store, traits: traits);
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    await tester.tap(find.text("That's wrong"));
    // Not pumpAndSettle: the card keeps a spinner turning behind the dialog
    // until the dialog is dismissed, so the tree never goes quiet.
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 120));
    }
    expect(traits.disputes, 1);
    expect(find.text('Tell us what’s actually true'), findsOneWidget);
    expect(find.textContaining('waiting on your profile'), findsOneWidget);

    await tester.tap(find.text('Answer now'));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 150));
    }

    // The correction's own screen, showing the generated question.
    expect(find.text('Put it right'), findsOneWidget);
    expect(find.text(_correction.text), findsOneWidget);
    // And emphatically NOT the "edit your five answers" screen.
    expect(find.text('Deepen your profile'), findsNothing);
    expect(find.text('Your answers'), findsNothing);
  });

  testWidgets('choosing Later leaves the correction findable on the profile',
      (tester) async {
    await _pump(tester, questions: _questions(dispute: _correction));
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('1 CORRECTION WAITING'), findsOneWidget);
    expect(find.text(_correction.text), findsOneWidget);

    await tester.tap(find.text(_correction.text));
    await tester.pumpAndSettle();
    expect(find.text('Put it right'), findsOneWidget);
  });

  testWidgets('with nothing waiting, the profile says nothing about corrections',
      (tester) async {
    await _pump(tester);
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.textContaining('CORRECTION'), findsNothing);
  });

  testWidgets('an already-answered correction explains itself instead of '
      'asking twice', (tester) async {
    final answered = _q('q-dispute', 'dispute',
        answered: true, text: _correction.text);
    final container = await _pump(tester, questions: _questions(dispute: answered));
    container.read(routerProvider).go('/profile/correct/q-dispute');
    await tester.pumpAndSettle();

    expect(find.text('ALREADY ANSWERED'), findsOneWidget);
    expect(find.text('Back to your profile'), findsOneWidget);
  });
}
