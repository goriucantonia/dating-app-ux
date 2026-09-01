import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dating_app_ux/app/app.dart';
import 'package:dating_app_ux/features/debug/health_screen.dart';

void main() {
  testWidgets('app builds and shows the debug health screen', (tester) async {
    // The real network call is Step 1's acceptance criterion on the running
    // stack; the widget test only proves the shell renders the payload.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          healthProvider.overrideWith(
            (ref) async => {'status': 'ok', 'database': 'connected'},
          ),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Server health (debug)'), findsOneWidget);
    expect(find.textContaining('connected'), findsOneWidget);
  });
}
