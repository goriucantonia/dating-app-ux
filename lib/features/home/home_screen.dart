import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/layout_shell.dart';
import '../../core/auth/auth_controller.dart';

/// Placeholder home. The real dashboard (hero + history) arrives in Step 10;
/// until then this renders the live GET /me payload — the Step 4 witness that
/// the whole auth loop works over the wire.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dating App AI'),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            icon: const Icon(Icons.logout),
            onPressed: () =>
                ref.read(authControllerProvider.notifier).logOut(),
          ),
        ],
      ),
      body: LayoutShell(
        child: Center(
          child: auth.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('Something went wrong: $e'),
            data: (user) => user == null
                ? const CircularProgressIndicator() // redirect is in flight
                : Card(
                    margin: const EdgeInsets.all(24),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Signed in as ${user.displayName}',
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 8),
                          Text('${user.email} · ${user.age} · ${user.gender}'),
                          Text(
                              'Looking for ${user.interestedIn.join(", ")} · ${user.agePrefMin}–${user.agePrefMax}'),
                          Text('Open to matching: ${user.optIn ? "yes" : "no"}'),
                          const SizedBox(height: 16),
                          Text(
                            'Your 5 onboarding questions arrive in the next build step.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
