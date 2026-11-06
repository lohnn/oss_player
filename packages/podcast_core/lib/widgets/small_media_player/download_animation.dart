/// Kept as scaffolding for a future download re-implementation; see PR #99
/// review thread — the download logic itself was removed in that rework.
///
/// The old progress source (the `EpisodeLoader` download pipeline) is gone,
/// so this renders the Download artboard with a null progress until offline
/// downloads come back as a real feature (a null progress was always a
/// possible input to the artboard, so nothing else changes).
library;

import 'package:flutter/material.dart';
import 'package:podcast_core/data/episode.model.dart';
import 'package:podcast_core/widgets/rive/podcast_animation.dart';
import 'package:podcast_core/widgets/rive/podcast_animation_config.dart';

class DownloadAnimation extends StatelessWidget {
  const DownloadAnimation({super.key, required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    // No progress source on purpose: see the doc comment above.
    const double? progress = null;

    return PodcastAnimation(
      animationArtboard: PodcastAnimationConfig.download(progress: progress),
    );
  }
}
