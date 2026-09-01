import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dating_app_ux/app/app.dart';
import 'package:dating_app_ux/core/auth/auth_controller.dart';
import 'package:dating_app_ux/features/auth/models.dart';

class _SignedOut extends AuthController {
  @override
  Future<User?> build() async => null;
}

void main() {
  testWidgets('signed-out app lands on the login screen (the one guard)',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authControllerProvider.overrideWith(_SignedOut.new)],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Sign in'), findsWidgets);
    expect(find.text('New here? Create an account'), findsOneWidget);
  });
}
