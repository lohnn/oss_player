import 'package:podcast_core/data/episode.model.dart';

import 'package:podcast_core/data/user_episode_status.model.dart';
import 'package:podcast_core/helpers/equatable_map.dart';
import 'package:podcast_core/providers/app_lifecycle_state_provider.dart';
import 'package:podcast_core/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_episode_status_provider.g.dart';

@riverpod
Future<UserEpisodeStatus> userEpisodeStatus(Ref ref, EpisodeId episodeId) {
  throw UnimplementedError(
    'This provider should be overridden by the app to provide a concrete implementation',
  );
}

@riverpod
class UserEpisodeStatusPod extends _$UserEpisodeStatusPod {
  late Repository _repository;

  @override
  Stream<EquatableMap<EpisodeId, UserEpisodeStatus>> build() async* {
    _repository = await ref.watch(repositoryProvider.future);

    final lifecycleState = ref.watch(appLifecycleStatePodProvider);
    if (lifecycleState != AppLifecycleState.resumed) return;

    ref.keepAlive();
    await for (final status in _repository.watchUserEpisodeStatuses()) {
      yield {for (final status in status) status.episodeId: status}.equatable;
    }
  }

  Future<void> markListened(EpisodeId episodeId) {
    return _repository.markEpisodeListened(episodeId);
  }

  Future<void> markUnlistened(EpisodeId episodeId) {
    return _repository.markEpisodeListened(episodeId, isPlayed: false);
  }
}
