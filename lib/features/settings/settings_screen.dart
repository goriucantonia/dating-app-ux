import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout_shell.dart';
import '../../core/api/api_client.dart';
import '../../core/auth/auth_controller.dart';
import '../auth/auth_repository.dart';

/// `/settings` (S8-U8) — the opt-in toggle with its one-line description,
/// editable preferences, and sign out.
///
/// **Delete account is deliberately absent.** It ships in Step 15 with its
/// server counterpart (`DELETE /me` and the cascade), because a delete button
/// that half-works is worse than one that does not exist yet.
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _busy = false;

  Future<void> _patch(Map<String, dynamic> changes) async {
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      final updated = await ref.read(authRepositoryProvider).patchMe(changes);
      ref.read(authControllerProvider.notifier).adopt(updated);
      messenger.showSnackBar(const SnackBar(content: Text('Saved.')));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      // Every user-triggered action ends in a visible outcome (D-005).
      messenger.showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/profile'),
        ),
      ),
      body: LayoutShell(
        child: auth.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('$e')),
          data: (user) {
            if (user == null) return const SizedBox.shrink();
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Matching', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Card(
                  margin: EdgeInsets.zero,
                  child: SwitchListTile(
                    value: user.optIn,
                    onChanged: _busy
                        ? null
                        : (v) => _patch({'opt_in': v}),
                    title: const Text('Open to matching'),
                    // The one-line description that has to sit next to the
                    // toggle, not behind a help link (A1).
                    subtitle: const Text(
                      'Your profile can be shown to other people using this '
                      'app, and theirs to you. Off means nobody sees you.',
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text('You', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Card(
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('Name'),
                        subtitle: Text(user.displayName),
                        trailing: const Icon(Icons.edit, size: 18),
                        onTap: _busy
                            ? null
                            : () => _editText(
                                  title: 'Your name',
                                  initial: user.displayName,
                                  field: 'display_name',
                                ),
                      ),
                      ListTile(
                        title: const Text('Email'),
                        subtitle: Text(user.email),
                        // Not editable this phase: it is the login identity and
                        // there is no verification flow to re-prove a new one.
                        enabled: false,
                      ),
                      ListTile(
                        title: const Text('Age'),
                        subtitle: Text('${user.age}'),
                        enabled: false,
                      ),
                      ListTile(
                        title: const Text('City'),
                        subtitle: Text(user.city ?? 'Not set'),
                        trailing: const Icon(Icons.edit, size: 18),
                        onTap: _busy
                            ? null
                            : () => _editText(
                                  title: 'City',
                                  initial: user.city ?? '',
                                  field: 'city',
                                ),
                      ),
                      ListTile(
                        title: const Text('Country'),
                        subtitle: Text(user.country ?? 'Not set'),
                        trailing: const Icon(Icons.edit, size: 18),
                        onTap: _busy
                            ? null
                            : () => _editText(
                                  title: 'Country',
                                  initial: user.country ?? '',
                                  field: 'country',
                                ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text('Who you want to meet',
                    style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    title: const Text('Age range'),
                    subtitle:
                        Text('${user.agePrefMin} – ${user.agePrefMax}'),
                    trailing: const Icon(Icons.edit, size: 18),
                    onTap: _busy ? null : () => _editAgeRange(user.agePrefMin, user.agePrefMax),
                  ),
                ),
                const SizedBox(height: 32),
                OutlinedButton.icon(
                  onPressed: () =>
                      ref.read(authControllerProvider.notifier).logOut(),
                  icon: const Icon(Icons.logout),
                  label: const Text('Sign out'),
                ),
                const SizedBox(height: 16),
                Text(
                  'Deleting your account arrives in a later build step.',
                  style: theme.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _editText({
    required String title,
    required String initial,
    required String field,
  }) async {
    final controller = TextEditingController(text: initial);
    final value = await showDialog<String?>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
              child: const Text('Save')),
        ],
      ),
    );
    controller.dispose();
    if (value == null || value == initial) return;
    await _patch({field: value.isEmpty ? null : value});
  }

  Future<void> _editAgeRange(int min, int max) async {
    var range = RangeValues(min.toDouble(), max.toDouble());
    final result = await showDialog<RangeValues?>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: const Text('Age range'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${range.start.round()} – ${range.end.round()}'),
              RangeSlider(
                values: range,
                min: 18,
                max: 99,
                divisions: 81,
                labels: RangeLabels(
                    '${range.start.round()}', '${range.end.round()}'),
                onChanged: (v) => setLocal(() => range = v),
              ),
              const Text('Minimum is 18.'),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () => Navigator.of(ctx).pop(range),
                child: const Text('Save')),
          ],
        ),
      ),
    );
    if (result == null) return;
    await _patch({
      'age_pref_min': result.start.round(),
      'age_pref_max': result.end.round(),
    });
  }
}
