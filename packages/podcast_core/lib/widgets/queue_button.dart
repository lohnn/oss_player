import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podcast_core/data/episode.model.dart';
import 'package:podcast_core/gen/strings.g.dart';
import 'package:podcast_core/providers/playlist_pod_provider.dart';
import 'package:podcast_core/widgets/rive/podcast_animation.dart';
import 'package:podcast_core/widgets/rive/podcast_animation_config.dart';

class QueueButton extends ConsumerWidget {
  final Episode episode;

  const QueueButton({super.key, required this.episode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // @TODO: Verify why provider is rebuilding multiple times
    final queue = ref.watch(playlistPodProvider).value ?? [];

    final onPressed = switch (queue.contains(episode)) {
      true => () {
        HapticFeedback.vibrate();
        ref.read(playlistPodProvider.notifier).removeFromQueue(episode);
      },
      false => () {
        HapticFeedback.mediumImpact();
        ref.read(playlistPodProvider.notifier).addToBottomOfQueue(episode);
      },
    };

    final tooltip = switch (queue.contains(episode)) {
      true => context.t.queue.removeFromQueue,
      false => context.t.queue.addToQueue,
    };

    final color = switch (queue.contains(episode)) {
      true => Theme.of(
        context,
      ).colorScheme.errorContainer.withValues(alpha: 0.85),
      false => null,
    };

    return Tooltip(
      message: tooltip,
      child: FilledButton.tonal(
        style: FilledButton.styleFrom(backgroundColor: color),
        onPressed: onPressed,
        child: Semantics(
          label: tooltip,
          child: PodcastAnimation(
            animationArtboard: PodcastAnimationConfig.queue(
              isAlreadyInQueue: queue.contains(episode),
            ),
          ),
        ),
      ),
    );
  }
}
