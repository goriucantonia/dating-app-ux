import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The **Modernist** design system, adapted from the Claude Design canvas
/// `Ranking & Date Reveal.dc.html` and its `_ds/modernist-*` token sheet
/// (closes O-18).
///
/// The system in one sentence: flat, architectural, set entirely in Archivo —
/// a near-mono red on an off-white ground, zero corner radius anywhere, and
/// strong 2px rules doing all the organising that shadows and rounded cards
/// used to do.
///
/// **The rules, taken verbatim from the design system's readme:**
/// - Never round a corner. `--radius-md` is 0 on purpose.
/// - Never centre a button label; a button wider than its label starts its
///   text at the left padding edge.
/// - Don't soften the 2px dividers into hairlines, and don't drop them for
///   whitespace — alignment and the strength of the rules do the organising.
/// - The accent is used sparingly: the primary action and small emphasis.
///   Body-size text in the accent uses the deep step (#ae1800), not the
///   accent itself, because the accent-to-ground pair is only tuned to 3:1.
///
/// Two departures from `ux_architecture.md` §1.6 ("one seed colour"), both
/// deliberate and named:
/// 1. The scheme is written out rather than derived from a seed. A generated
///    scheme cannot hold a mono palette — `fromSeed` invents a green tertiary
///    and a purple secondary, and this system has exactly one accent.
/// 2. Dark mode is the same system inverted (ground and ink swap, accent
///    lifts one ramp step for contrast on dark), not a second palette. The
///    design's 1b grid already prints one candidate column dark.
abstract final class AppTheme {
  // The token sheet, one place. Names match `_ds/.../styles.css` variables so
  // the two can be diffed by eye.
  static const bg = Color(0xFFF3F2F2); // --color-bg
  static const surface = Color(0xFFEAE9E9); // --color-surface
  static const ink = Color(0xFF201E1D); // --color-text
  static const accent = Color(0xFFEC3013); // --color-accent
  static const accent100 = Color(0xFFFFF2EF);
  static const accent200 = Color(0xFFFFE0D9);
  static const accent400 = Color(0xFFFF9783);
  static const accent500 = Color(0xFFFF563C);
  static const accent600 = Color(0xFFDD2B0F);
  static const accent700 = Color(0xFFAE1800);
  static const accent800 = Color(0xFF7C1405);
  static const neutral300 = Color(0xFFD7D3D3);
  static const neutral700 = Color(0xFF605D5D); // the muted ink
  static const neutral900 = Color(0xFF2D2B2B);

  /// `--color-divider`: the ink at 40%, drawn 2px. Not a hairline.
  static const divider = Color(0x66201E1D);

  static const double dividerWidth = 2;

  /// Archivo, at the two weights the system uses: 800 for anything
  /// structural, 400/600 for prose. Runtime-fetched by `google_fonts`;
  /// **named trade** — offline, the app falls back to the platform sans and
  /// keeps every weight, size and letter-spacing below, so the layout is
  /// identical and only the letterforms differ.
  static TextTheme _typography(TextTheme base, Color onGround, Color muted) {
    final archivo = GoogleFonts.archivoTextTheme(base);
    TextStyle head(TextStyle? s, double size, {double tracking = -0.015}) =>
        (s ?? const TextStyle()).copyWith(
          fontSize: size,
          fontWeight: FontWeight.w800,
          letterSpacing: size * tracking,
          height: 1.1,
          color: onGround,
        );
    // The uppercase micro-label the whole design runs on: 10–13px, w800,
    // wide tracking, muted. Every "FINAL", "SEQ 1", "PARTIAL · WEIGHTED ×0.5".
    TextStyle micro(TextStyle? s, double size) =>
        (s ?? const TextStyle()).copyWith(
          fontSize: size,
          fontWeight: FontWeight.w800,
          letterSpacing: size * 0.08,
          color: muted,
        );
    return archivo.copyWith(
      displayLarge: head(archivo.displayLarge, 64, tracking: -0.04),
      displayMedium: head(archivo.displayMedium, 48, tracking: -0.035),
      displaySmall: head(archivo.displaySmall, 38, tracking: -0.03),
      headlineLarge: head(archivo.headlineLarge, 42),
      headlineMedium: head(archivo.headlineMedium, 32),
      headlineSmall: head(archivo.headlineSmall, 25),
      titleLarge: head(archivo.titleLarge, 25),
      titleMedium: head(archivo.titleMedium, 20),
      titleSmall: head(archivo.titleSmall, 16),
      bodyLarge: archivo.bodyLarge?.copyWith(
          fontSize: 16, height: 1.5, color: onGround),
      bodyMedium: archivo.bodyMedium?.copyWith(
          fontSize: 15, height: 1.5, color: onGround),
      bodySmall: archivo.bodySmall?.copyWith(
          fontSize: 13, height: 1.5, color: muted),
      labelLarge: micro(archivo.labelLarge, 13).copyWith(color: onGround),
      labelMedium: micro(archivo.labelMedium, 11),
      labelSmall: micro(archivo.labelSmall, 10),
    );
  }

  static ThemeData _build({required bool dark}) {
    final ground = dark ? ink : bg;
    final onGround = dark ? bg : ink;
    final raised = dark ? neutral900 : surface;
    final muted = dark ? neutral300 : neutral700;
    // On a dark ground the accent lifts one ramp step (the readme's rule);
    // body-size accent text drops to the deep step on light.
    final act = dark ? accent500 : accent;
    final tint = dark ? neutral900 : accent200;
    final onTint = dark ? accent400 : accent800;

    final scheme = ColorScheme(
      brightness: dark ? Brightness.dark : Brightness.light,
      primary: act,
      onPrimary: dark ? ink : bg,
      primaryContainer: tint,
      onPrimaryContainer: onTint,
      // The mono palette: secondary and tertiary are the same accent role,
      // not invented hues. Tertiary is the deep step, which is what the
      // "partial / attention" copy is set in.
      secondary: onGround,
      onSecondary: ground,
      secondaryContainer: tint,
      onSecondaryContainer: onTint,
      tertiary: dark ? accent400 : accent700,
      onTertiary: dark ? ink : bg,
      tertiaryContainer: tint,
      onTertiaryContainer: onTint,
      error: dark ? accent400 : accent700,
      onError: dark ? ink : bg,
      errorContainer: tint,
      onErrorContainer: onTint,
      surface: ground,
      onSurface: onGround,
      surfaceContainerLowest: ground,
      surfaceContainerLow: ground,
      surfaceContainer: raised,
      surfaceContainerHigh: raised,
      surfaceContainerHighest: raised,
      onSurfaceVariant: muted,
      outline: muted,
      outlineVariant: dark ? const Color(0x66F3F2F2) : divider,
      shadow: neutral900,
      scrim: neutral900,
      inverseSurface: onGround,
      onInverseSurface: ground,
      inversePrimary: act,
    );

    const square = RoundedRectangleBorder(borderRadius: BorderRadius.zero);
    final text = _typography(
        dark ? Typography.whiteMountainView : Typography.blackMountainView,
        onGround,
        muted);

    // Flush-left labels, square edges, and a themed hover/pressed state off
    // the accent ramp — never a browser default.
    ButtonStyle buttonBase(Color fg) => ButtonStyle(
          alignment: Alignment.centerLeft,
          shape: const WidgetStatePropertyAll(square),
          padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 14, vertical: 12)),
          textStyle: WidgetStatePropertyAll(text.titleSmall?.copyWith(
              fontSize: 14, letterSpacing: 0, height: 1.2)),
          overlayColor: WidgetStatePropertyAll(fg.withValues(alpha: 0.08)),
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: ground,
      canvasColor: ground,
      textTheme: text,
      splashFactory: NoSplash.splashFactory,
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: dividerWidth,
        space: dividerWidth,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ground,
        foregroundColor: onGround,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.titleMedium,
        shape: Border(
            bottom: BorderSide(
                color: scheme.outlineVariant, width: dividerWidth)),
      ),
      cardTheme: CardThemeData(
        color: raised,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: scheme.outlineVariant, width: dividerWidth),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: buttonBase(scheme.onPrimary).copyWith(
          backgroundColor: WidgetStateProperty.resolveWith((s) =>
              s.contains(WidgetState.disabled)
                  ? muted.withValues(alpha: 0.35)
                  : s.contains(WidgetState.pressed)
                      ? (dark ? accent400 : accent600)
                      : act),
          foregroundColor: WidgetStatePropertyAll(scheme.onPrimary),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: buttonBase(onGround).copyWith(
          foregroundColor: WidgetStatePropertyAll(onGround),
          side: WidgetStatePropertyAll(
              BorderSide(color: scheme.outlineVariant, width: 1)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: buttonBase(act).copyWith(
          foregroundColor: WidgetStatePropertyAll(dark ? accent400 : accent700),
          padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: square,
        side: BorderSide(color: scheme.outlineVariant, width: 1),
        backgroundColor: tint,
        labelStyle: text.bodySmall?.copyWith(color: onTint),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: raised,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: scheme.outlineVariant, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: scheme.outlineVariant, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: act, width: dividerWidth),
        ),
      ),
      dialogTheme: DialogThemeData(
          backgroundColor: ground, surfaceTintColor: Colors.transparent, shape: square),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: ground,
          surfaceTintColor: Colors.transparent,
          shape: square),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: onGround,
        contentTextStyle: text.bodyMedium?.copyWith(color: ground),
        shape: square,
        behavior: SnackBarBehavior.floating,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: act, linearTrackColor: raised, circularTrackColor: raised),
      expansionTileTheme: ExpansionTileThemeData(
          shape: const Border(), collapsedShape: const Border()),
      listTileTheme: const ListTileThemeData(shape: square),
      extensions: [dark ? Modernist.dark : Modernist.light],
    );
  }

  static ThemeData get light => _build(dark: false);
  static ThemeData get dark => _build(dark: true);
}

/// The handful of roles Material's `ColorScheme` has no slot for, which the
/// results screens need by name: the plot ground, the two curve strokes, and
/// the ink of the rules.
///
/// [of] falls back to the light tokens when the extension is absent, so a
/// widget test that pumps a bare `MaterialApp` still renders the design
/// rather than throwing.
@immutable
class Modernist extends ThemeExtension<Modernist> {
  const Modernist({
    required this.rule,
    required this.plot,
    required this.gridline,
    required this.you,
    required this.them,
    required this.tint,
    required this.onTint,
    required this.muted,
  });

  /// The 2px divider ink.
  final Color rule;

  /// The flat ground a chart is drawn on (`--color-surface`).
  final Color plot;

  /// The faint horizontal rules inside a chart.
  final Color gridline;

  /// Your agent's curves (the accent) and theirs (the ink).
  final Color you;
  final Color them;

  /// The accent tint used for "what clicked" chips and tinted notices.
  final Color tint;
  final Color onTint;

  /// `--color-neutral-700`, the label ink.
  final Color muted;

  static const light = Modernist(
    rule: AppTheme.divider,
    plot: AppTheme.surface,
    gridline: Color(0x24201E1D),
    you: AppTheme.accent,
    them: AppTheme.ink,
    tint: AppTheme.accent200,
    onTint: AppTheme.accent800,
    muted: AppTheme.neutral700,
  );

  static const dark = Modernist(
    rule: Color(0x66F3F2F2),
    plot: AppTheme.neutral900,
    gridline: Color(0x24F3F2F2),
    you: AppTheme.accent500,
    them: AppTheme.bg,
    tint: AppTheme.neutral900,
    onTint: AppTheme.accent400,
    muted: AppTheme.neutral300,
  );

  static Modernist of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<Modernist>() ??
        (theme.brightness == Brightness.dark ? dark : light);
  }

  @override
  Modernist copyWith({
    Color? rule,
    Color? plot,
    Color? gridline,
    Color? you,
    Color? them,
    Color? tint,
    Color? onTint,
    Color? muted,
  }) =>
      Modernist(
        rule: rule ?? this.rule,
        plot: plot ?? this.plot,
        gridline: gridline ?? this.gridline,
        you: you ?? this.you,
        them: them ?? this.them,
        tint: tint ?? this.tint,
        onTint: onTint ?? this.onTint,
        muted: muted ?? this.muted,
      );

  @override
  Modernist lerp(Modernist? other, double t) {
    if (other == null) return this;
    return Modernist(
      rule: Color.lerp(rule, other.rule, t)!,
      plot: Color.lerp(plot, other.plot, t)!,
      gridline: Color.lerp(gridline, other.gridline, t)!,
      you: Color.lerp(you, other.you, t)!,
      them: Color.lerp(them, other.them, t)!,
      tint: Color.lerp(tint, other.tint, t)!,
      onTint: Color.lerp(onTint, other.onTint, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
    );
  }
}

/// The uppercase micro-label, the design's smallest unit of structure
/// ("FINAL", "SEQ 1", "MEAN OF 2 DATES"). Shared so the tracking and weight
/// are defined once (§13/§16: the difference between two of these is the
/// text, never a re-implementation).
class Kicker extends StatelessWidget {
  const Kicker(this.text, {super.key, this.colour, this.size = 10});

  final String text;
  final Color? colour;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontSize: size,
            color: colour ?? Modernist.of(context).muted,
          ),
    );
  }
}

/// A square outlined tag — "DEMO", "PARTIAL · WEIGHTED ×0.5", "NOT SCORED".
class Tag extends StatelessWidget {
  const Tag(this.text, {super.key, this.colour, this.filled = false});

  final String text;
  final Color? colour;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final m = Modernist.of(context);
    final c = colour ?? m.muted;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: filled ? c : null,
        border: filled ? null : Border.all(color: c),
      ),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: filled ? Theme.of(context).colorScheme.surface : c,
            ),
      ),
    );
  }
}

/// The 2px rule the system organises with.
class Rule extends StatelessWidget {
  const Rule({super.key, this.inset = EdgeInsets.zero});

  final EdgeInsetsGeometry inset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: inset,
      child: Container(height: AppTheme.dividerWidth, color: Modernist.of(context).rule),
    );
  }
}
