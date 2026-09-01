import 'package:flutter/material.dart';

/// Material 3, light + dark from ONE seed colour (ux_architecture.md §1.6).
/// Changing the app's look is changing [_seed], nothing else.
abstract final class AppTheme {
  static const _seed = Color(0xFFE0526E); // warm rose

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _seed),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seed,
          brightness: Brightness.dark,
        ),
      );
}
