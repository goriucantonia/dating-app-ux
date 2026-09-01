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
/// Delete account (S15-U1): a two-step confirm that states what deletion does
/// — including the cross-user effect in plain words — then shows the server's
/// counts as the final receipt. Only then does the app sign out.
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
                const SizedBox(height: 24),
                Text('Danger zone', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.error),
                  onPressed: _busy ? null : _deleteAccount,
                  icon: const Icon(Icons.delete_forever_outlined),
                  label: const Text('Delete my account'),
                ),
                const SizedBox(height: 32),
              ],
            );
          },
        ),
      ),
    );
  }

  /// S15-U1. Step one says what deletion does; step two asks again with the
  /// cross-user effect in plain words; the receipt is the server's own count.
  Future<void> _deleteAccount() async {
    final first = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete your account?'),
        content: const Text(
          'Everything you wrote, every trait the AI read from it, your AI self, '
          'your analyses, your simulated dates and your chats — all of it goes, '
          'for good. There is no undo.',
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Keep my account')),
          FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Continue')),
        ],
      ),
    );
    if (first != true || !mounted) return;
    final second = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('One more thing'),
        content: const Text(
          'Your simulated dates disappear from your friends’ results too, and '
          'any chat they started with your AI self goes with them. They will '
          'see “this person removed their account” where you used to be.\n\n'
          'Delete everything?',
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('No, keep it')),
          FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(ctx).colorScheme.error),
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Yes, delete everything')),
        ],
      ),
    );
    if (second != true || !mounted) return;

    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    DeletionReceipt receipt;
    try {
      receipt = await ref.read(authRepositoryProvider).deleteMe();
    } on ApiException catch (e) {
      if (mounted) setState(() => _busy = false);
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
      return;
    } catch (e) {
      if (mounted) setState(() => _busy = false);
      messenger.showSnackBar(SnackBar(content: Text('$e')));
      return;
    }
    if (!mounted) return;
    // The receipt: the server's own counts, taken before the cascade ran.
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Your account is gone'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${receipt.rowsRemoved} rows were removed:'),
              const SizedBox(height: 8),
              for (final e in receipt.deleted.entries)
                if (e.value > 0)
                  Text('${e.value} × ${e.key.replaceAll('_', ' ')}',
                      style: Theme.of(ctx).textTheme.bodySmall),
            ],
          ),
        ),
        actions: [
          FilledButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Done')),
        ],
      ),
    );
    if (!mounted) return;
    await ref.read(authControllerProvider.notifier).logOut();
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
