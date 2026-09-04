import 'package:flutter/material.dart';

/// The Demo chip (S10-U9) — **retired as a visible element** by owner decision
/// on 2026-09-02 ("do not use that"). `is_demo` still arrives on the wire and
/// still guards the server (a demo account cannot be edited or deleted); the
/// UI just no longer labels people with it.
///
/// Kept as a widget so every call site stays `DemoChip(isDemo: x.isDemo)` and
/// the decision can be reversed in ONE place rather than re-plumbed through
/// seven screens.
class DemoChip extends StatelessWidget {
  const DemoChip({super.key, required this.isDemo, this.compact = false});

  final bool isDemo;
  final bool compact;

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
