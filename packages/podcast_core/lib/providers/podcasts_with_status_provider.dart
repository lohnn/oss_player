import 'package:collection/collection.dart';
import 'package:podcast_core/data/podcast.model.dart';
import 'package:podcast_core/data/podcast_with_status.dart';
import 'package:podcast_core/helpers/equatable_list.dart';
import 'package:podcast_core/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'podcasts_with_status_provider.g.dart';

@riverpod
Future<PodcastWithStatus?> podcastWithStatus(
  Ref ref,
  PodcastId podcastId,
) async {
  return (await ref.watch(
    podcastsWithStatusProvider.future,
  )).firstWhereOrNull((podcast) => podcast.podcast.id == podcastId);
}

@riverpod
class PodcastsWithStatus extends _$PodcastsWithStatus {
  late Repository _repository;

  @override
  Stream<EquatableList<PodcastWithStatus>> build() async* {
    _repository = await ref.watch(repositoryProvider.future);
    // @TODO: Maybe find a way to store the value locally as well for offline first

    // keepUpToDateWithSubscriptions();

    // _listenPodcastChanges();
    // _listenToTableChanges();

    yield* _repository.watchPodcasts().map(EquatableList.new);
  }

  Future<void> refresh(Podcast podcast) {
    return _repository.refreshPodcast(podcast.url);
  }

  Future<void> updateLastSeen(PodcastId podcastId) {
    return _repository.updateLastSeenPodcast(podcastId);
  }

  // void _listenToTableChanges() {
  //   // Update on user podcast subscriptions change, such as when last_seen is updated
  //   // @TODO: Trigger reload only on the podcast to which the episode belongs
  //   ref.listenListenable(
  //     _repository.userPodcastSubscriptionsChanges,
  //     ref.invalidateSelf,
  //   );
  //
  //   // New episodes should trigger a reload
  //   // @TODO: Trigger reload only on the podcast to which the episode belongs
  //   ref.listenListenable(_repository.episodesUpdated, ref.invalidateSelf);
  //
  //   // @TODO: Trigger reload only on the podcast to which the episode belongs
  //   ref.listen(userEpisodeStatusPodProvider, (oldValue, newValue) {
  //     final oldStatus = oldValue?.value;
  //     final newStatus = newValue.value;
  //     if (oldStatus == null) return;
  //     if (newStatus == null) return;
  //     if (oldStatus == newStatus) return;
  //
  //     final oldListenedStatus = oldStatus.values
  //         .map((value) => value.isPlayed)
  //         .equatable;
  //     final newListenedStatus = newStatus.values
  //         .map((value) => value.isPlayed)
  //         .equatable;
  //
  //     if (oldListenedStatus != newListenedStatus) {
  //       ref.invalidateSelf();
  //     }
  //   });
  // }

  // void _listenPodcastChanges() {
  //   ref.listen(podcastsProvider, fireImmediately: true, (
  //     oldValue,
  //     newValue,
  //   ) async {
  //     final oldPodcasts = oldValue?.value;
  //     final newPodcasts = newValue.value;
  //
  //     // If there is no podcasts in new value, we can just skip this
  //     if (newPodcasts == null) return;
  //     // Podcast list didn't actually update, let's just ignore
  //     if (newPodcasts == oldPodcasts) return;
  //     // If we don't already show data, let's first show converted null list
  //     if (state is! AsyncData) {
  //       state = AsyncData(
  //         [
  //           for (final podcast in newPodcasts)
  //             PodcastWithStatus.notListened(podcast: podcast),
  //         ].equatable,
  //       );
  //     }
  //
  //     final podcastsWithCount = await _repository.getPodcastsWithCount();
  //
  //     state = AsyncData(podcastsWithCount.equatable);
  //   });
  // }
}
