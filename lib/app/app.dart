import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/notify/completion.dart';
import 'router.dart';
import 'theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Dating App AI',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // System-following: the OS decides light vs dark (ux_architecture.md §1.6).
      themeMode: ThemeMode.system,
      routerConfig: router,
      // S13-U4: the app-wide messenger and the listener that uses it, so
      // "your dates have finished" reaches the user wherever they are.
      scaffoldMessengerKey: scaffoldMessengerKey,
      builder: (context, child) => CompletionListener(
        // The router object itself — see the note in CompletionListener about
        // why a context lookup cannot work from here (D-019).
        onOpen: router.go,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
