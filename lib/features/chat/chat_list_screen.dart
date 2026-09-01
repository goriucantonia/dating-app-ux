import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout_shell.dart';
import '../../core/api/api_client.dart';
import '../common/demo_chip.dart';
import 'chat_repository.dart';
import 'models.dart';

/// `/chat` — the session list (S14-U3). Active first, then ended; each row
/// carries the match's name, the Demo chip where it applies, the last line,
/// and the way back to the analysis it came from.
class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(chatSessionsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your chats'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: LayoutShell(
        child: RefreshIndicator(
          onRefresh: () async => ref.invalidate(chatSessionsProvider),
          child: sessions.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => _ErrorRetry(
              message: e is ApiException ? e.message : "Couldn't load your chats.",
              onRetry: () => ref.invalidate(chatSessionsProvider),
            ),
            data: (list) => _List(sessions: list),
          ),
        ),
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({required this.sessions});

  final List<ChatSessionSummary> sessions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (sessions.isEmpty) {
      return ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 48),
          Icon(Icons.forum_outlined, size: 48, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text(
            'No chats yet. Run an analysis, read how the dates went, and '
            'choose someone — the chat starts there.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Center(
            child: FilledButton(
              onPressed: () => context.go('/'),
              child: const Text('To the dashboard'),
            ),
          ),
        ],
      );
    }
    final active = sessions.where((s) => s.status == 'active').toList();
    final ended = sessions.where((s) => s.status != 'active').toList();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (active.isNotEmpty) ...[
          Text('Active', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          for (final s in active) _Row(session: s),
          const SizedBox(height: 16),
        ],
        if (ended.isNotEmpty) ...[
          Text('Ended', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text('Still readable — just no longer open for new messages.',
              style: theme.textTheme.bodySmall),
          const SizedBox(height: 4),
          for (final s in ended) _Row(session: s),
        ],
        const SizedBox(height: 32),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.session});

  final ChatSessionSummary session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = session;
    final last = s.lastMessage;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: () => context.push('/chat/${s.sessionId}'),
        leading: CircleAvatar(
          child: Text(s.match.displayName.isEmpty ? '?' : s.match.displayName[0]),
        ),
        title: Row(
          children: [
            Flexible(child: Text(s.match.displayName)),
            DemoChip(isDemo: s.match.isDemo, compact: true),
            const SizedBox(width: 6),
            // Immersive, never deceptive (S14-U5).
            Text('AI persona', style: theme.textTheme.labelSmall),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              last == null
                  ? 'Say hello.'
                  : '${last.sender == 'user' ? 'You: ' : ''}${last.text}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            GestureDetector(
              onTap: () => context.push('/analyses/${s.analysisId}/results'),
              child: Text(
                'From your analysis · see the dates',
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: theme.colorScheme.primary),
              ),
            ),
          ],
        ),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off, size: 48),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          FilledButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
    );
  }
}
