import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podcast_core/data/episode.model.dart';
import 'package:podcast_core/gen/strings.g.dart';
import 'package:podcast_core/providers/audio_player_provider.dart';

class PlayEpisodeButton extends ConsumerWidget {
  final Episode episode;

  const PlayEpisodeButton(this.episode, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: context.t.playEpisodeButton.playEpisodeTooltip(title: episode.title),
      child: FilledButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          ref.read(audioPlayerPodProvider.notifier).playEpisode(episode);
        },
        child: Semantics(
          label: context.t.playEpisodeButton.playEpisodeSemanticLabel,
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
