import 'package:flutter/material.dart';

/// THE Demo chip (S10-U9, `ux_architecture.md` §1.6).
///
/// Used **everywhere a user is rendered**. `is_demo` arriving on the wire and
/// then being dropped by one widget is not a cosmetic bug: it is a person the
/// user believes is real, deciding to spend an evening on a date with them.
///
/// Written as a widget that renders NOTHING when `isDemo` is false, so the
/// call site is always `DemoChip(isDemo: x.isDemo)` with no `if`. An `if` at
/// the call site is a thing someone can forget; this is not.
class DemoChip extends StatelessWidget {
  const DemoChip({super.key, required this.isDemo, this.compact = false});

  final bool isDemo;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (!isDemo) return const SizedBox.shrink();
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: EdgeInsets.symmetric(horizontal: compact ? 6 : 8, vertical: 2),
      decoration: BoxDecoration(
        color: scheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'Demo',
        style: (compact
                ? Theme.of(context).textTheme.labelSmall
                : Theme.of(context).textTheme.labelMedium)
            ?.copyWith(
          color: scheme.onTertiaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
