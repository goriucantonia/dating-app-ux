import 'package:flutter/material.dart';

/// The one layout rule (ux_architecture.md §1.7): phone-first; above 840px the
/// content is a centered ~720px column. No per-platform layouts this phase
/// (named trade: desktop looks like a big phone; accepted).
///
/// Every screen's body goes through this shell so the rule lives in one place.
class LayoutShell extends StatelessWidget {
  const LayoutShell({super.key, required this.child});

  static const double _breakpoint = 840;
  static const double _columnWidth = 720;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width <= _breakpoint) return child;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _columnWidth),
        child: child,
      ),
    );
  }
}
