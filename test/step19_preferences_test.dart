/// Step 19 widget tests — editing who you are and who you want to meet.
///
/// From use: "Can the preferences about the sex of the person be changed? I do
/// not see where I can choose other options if I am interested in more people
/// — or my interests change!" They could not: `PATCH /me` had accepted
/// `interested_in` and `gender` since Step 4, and Settings offered neither
/// (D-020).
library;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dating_app_ux/core/auth/auth_controller.dart';
import 'package:dating_app_ux/features/auth/auth_repository.dart';
import 'package:dating_app_ux/features/auth/models.dart';
import 'package:dating_app_ux/features/settings/settings_screen.dart';

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

class _FakeAuth extends AuthRepository {
  _FakeAuth() : super(Dio());

  final List<Map<String, dynamic>> patches = [];
  User user = _me;

  @override
  Future<User> patchMe(Map<String, dynamic> changes) async {
    patches.add(changes);
    user = user.copyWith(
      gender: changes['gender'] as String? ?? user.gender,
      interestedIn:
          (changes['interested_in'] as List?)?.cast<String>() ?? user.interestedIn,
    );
    return user;
  }
}

class _Auth extends AuthController {
  @override
  Future<User?> build() async => _me;
}

Future<_FakeAuth> _pump(WidgetTester tester) async {
  tester.view.physicalSize = const Size(800, 1600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final auth = _FakeAuth();
  await tester.pumpWidget(ProviderScope(
    overrides: [
      authControllerProvider.overrideWith(_Auth.new),
      authRepositoryProvider.overrideWithValue(auth),
    ],
    child: const MaterialApp(home: SettingsScreen()),
  ));
  await tester.pumpAndSettle();
  return auth;
}

void main() {
  testWidgets('both halves of the gender filter are on the screen and say '
      'what they currently are', (tester) async {
    await _pump(tester);
    expect(find.text('I am a…'), findsOneWidget);
    expect(find.text('woman'), findsOneWidget);
    expect(find.text('Interested in'), findsOneWidget);
    expect(find.text('man'), findsOneWidget);
  });

  testWidgets('interested-in can be widened to several at once', (tester) async {
    final auth = await _pump(tester);
    await tester.tap(find.text('Interested in'));
    await tester.pumpAndSettle();

    // Every option the server accepts is offered, and the current one is on.
    for (final g in genderValues) {
      expect(find.widgetWithText(FilterChip, g), findsOneWidget);
    }
    await tester.tap(find.widgetWithText(FilterChip, 'woman'));
    await tester.tap(find.widgetWithText(FilterChip, 'nonbinary'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(auth.patches, [
      {
        'interested_in': ['man', 'woman', 'nonbinary'],
      }
    ]);
  });

  testWidgets('choosing nobody is refused before it reaches the server',
      (tester) async {
    final auth = await _pump(tester);
    await tester.tap(find.text('Interested in'));
    await tester.pumpAndSettle();

    // Turning the only one off leaves an empty set — the server's own rule
    // (min_length=1), enforced as a disabled button rather than a 422.
    await tester.tap(find.widgetWithText(FilterChip, 'man'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Pick at least one'), findsOneWidget);
    final save = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, 'Save'));
    expect(save.onPressed, isNull);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(auth.patches, isEmpty);
  });

  testWidgets('the dialog says what changing it does, and what it does not',
      (tester) async {
    await _pump(tester);
    await tester.tap(find.text('Interested in'));
    await tester.pumpAndSettle();
    expect(find.textContaining('who you can be matched with from now on'),
        findsOneWidget);
    // The thing a person will otherwise assume, said out loud.
    expect(find.textContaining('already run keep the people they found'),
        findsOneWidget);
  });

  testWidgets('your own gender is editable too, because matching is mutual',
      (tester) async {
    final auth = await _pump(tester);
    await tester.tap(find.text('I am a…'));
    await tester.pumpAndSettle();
    expect(find.textContaining('changes who can be matched with you'),
        findsOneWidget);

    await tester.tap(find.widgetWithText(ChoiceChip, 'nonbinary'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(auth.patches, [
      {'gender': 'nonbinary'}
    ]);
  });

  testWidgets('cancelling changes nothing', (tester) async {
    final auth = await _pump(tester);
    await tester.tap(find.text('I am a…'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, 'other'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(auth.patches, isEmpty);
  });
}
