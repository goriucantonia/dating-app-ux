import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'theme.dart';

/// The app's ONE persistent navigation (S18-U1).
///
/// **Why this exists.** Every screen used to reach every other screen with its
/// own `context.go`, which replaces the stack rather than pushing onto it —
/// so `/profile` had no back button, no parent, and no route home except the
/// browser's own. The report that produced this widget was "after clicking on
/// Profile, I cannot easily go back to start a new analysis", and that is
/// exactly what the code did.
///
/// Four destinations, always visible, always in the same order, because a
/// person navigates by muscle memory and a bar that moves is not a bar. Each
/// keeps **its own stack**: going Profile → Deepen → Home → Profile lands back
/// on Deepen, where you left it.
///
/// Drawn in the Modernist idiom: a flat field under a 2px rule, square, the
/// selected destination marked by an accent block above its label rather than
/// a rounded pill.
class NavShell extends StatelessWidget {
  const NavShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  static const destinations = <({String label, IconData icon, String path})>[
    (label: 'Home', icon: Icons.home_outlined, path: '/'),
    (label: 'Profile', icon: Icons.person_outline, path: '/profile'),
    (label: 'Chats', icon: Icons.forum_outlined, path: '/chat'),
    (label: 'Settings', icon: Icons.tune_outlined, path: '/settings'),
  ];

  void _go(int index) {
    // Tapping the tab you are already on returns that branch to its root —
    // the standard escape hatch out of a stack you have wandered down.
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final m = Modernist.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: shell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: m.rule, width: AppTheme.dividerWidth),
          ),
          color: theme.colorScheme.surface,
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 62,
            child: Row(
              children: [
                for (var i = 0; i < destinations.length; i++)
                  Expanded(
                    child: _Destination(
                      destination: destinations[i],
                      selected: i == shell.currentIndex,
                      onTap: () => _go(i),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Destination extends StatelessWidget {
  const _Destination({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final ({String label, IconData icon, String path}) destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final m = Modernist.of(context);
    final colour = selected ? m.you : m.muted;
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // The marker is a hard 3px block, not a pill: the design system
            // has no rounded corners anywhere and this is not the exception.
            Container(
              height: 3,
              width: 26,
              color: selected ? m.you : Colors.transparent,
            ),
            const SizedBox(height: 8),
            Icon(destination.icon, size: 22, color: colour),
            const SizedBox(height: 3),
            Text(
              destination.label,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: colour, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

/// The back affordance every screen below a tab root uses (S18-U2).
///
/// `context.pop()` when there is something to pop, and the branch's own root
/// otherwise — so a screen opened by a deep link or a notification still has
/// somewhere sensible to go, instead of a back arrow that does nothing.
class BackTo extends StatelessWidget {
  const BackTo({super.key, required this.fallback, this.tooltip});

  final String fallback;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      tooltip: tooltip ?? 'Back',
      onPressed: () {
        final router = GoRouter.of(context);
        if (router.canPop()) {
          router.pop();
        } else {
          router.go(fallback);
        }
      },
    );
  }
}
