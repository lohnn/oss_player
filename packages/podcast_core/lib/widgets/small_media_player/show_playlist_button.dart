import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podcast_core/gen/strings.g.dart';
import 'package:podcast_core/screens/modals/episode_player_modal.dart';

class ShowPlaylistButton extends ConsumerWidget {
  const ShowPlaylistButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return IconButton(
      tooltip: context.t.episodePlayerModal.showPlaylist,
      onPressed: () {
        HapticFeedback.lightImpact();
        Navigator.of(context).pop(EpisodePlayerModalResultAction.showPlaylist);
      },
      icon: Icon(Icons.playlist_play, color: theme.colorScheme.primary),
    );
  }
}
