// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_episode_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserEpisodeStatusPod)
const userEpisodeStatusPodProvider = UserEpisodeStatusPodProvider._();

final class UserEpisodeStatusPodProvider
    extends
        $StreamNotifierProvider<
          UserEpisodeStatusPod,
          EquatableMap<EpisodeId, UserEpisodeStatus>
        > {
  const UserEpisodeStatusPodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userEpisodeStatusPodProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userEpisodeStatusPodHash();

  @$internal
  @override
  UserEpisodeStatusPod create() => UserEpisodeStatusPod();
}

String _$userEpisodeStatusPodHash() =>
    r'e1923ec82371b4e3c7044a555c1c2996511241b7';

abstract class _$UserEpisodeStatusPod
    extends $StreamNotifier<EquatableMap<EpisodeId, UserEpisodeStatus>> {
  Stream<EquatableMap<EpisodeId, UserEpisodeStatus>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<EquatableMap<EpisodeId, UserEpisodeStatus>>,
              EquatableMap<EpisodeId, UserEpisodeStatus>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EquatableMap<EpisodeId, UserEpisodeStatus>>,
                EquatableMap<EpisodeId, UserEpisodeStatus>
              >,
              AsyncValue<EquatableMap<EpisodeId, UserEpisodeStatus>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
