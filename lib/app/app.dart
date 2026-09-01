import 'package:flutter/material.dart';

import 'router.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dating App AI',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // System-following: the OS decides light vs dark (ux_architecture.md §1.6).
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
