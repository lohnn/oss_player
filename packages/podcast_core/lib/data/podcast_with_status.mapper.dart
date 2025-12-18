// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'podcast_with_status.dart';

class PodcastWithStatusMapper extends ClassMapperBase<PodcastWithStatus> {
  PodcastWithStatusMapper._();

  static PodcastWithStatusMapper? _instance;
  static PodcastWithStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PodcastWithStatusMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PodcastWithStatus';

  static Podcast _$podcast(PodcastWithStatus v) => v.podcast;
  static const Field<PodcastWithStatus, Podcast> _f$podcast = Field(
    'podcast',
    _$podcast,
  );
  static int? _$playedEpisodeCount(PodcastWithStatus v) => v.playedEpisodeCount;
  static const Field<PodcastWithStatus, int> _f$playedEpisodeCount = Field(
    'playedEpisodeCount',
    _$playedEpisodeCount,
    key: r'played_episode_count',
  );
  static int? _$episodeCount(PodcastWithStatus v) => v.episodeCount;
  static const Field<PodcastWithStatus, int> _f$episodeCount = Field(
    'episodeCount',
    _$episodeCount,
    key: r'episode_count',
  );
  static bool? _$hasUnseenEpisodes(PodcastWithStatus v) => v.hasUnseenEpisodes;
  static const Field<PodcastWithStatus, bool> _f$hasUnseenEpisodes = Field(
    'hasUnseenEpisodes',
    _$hasUnseenEpisodes,
    key: r'has_unseen_episodes',
  );

  @override
  final MappableFields<PodcastWithStatus> fields = const {
    #podcast: _f$podcast,
    #playedEpisodeCount: _f$playedEpisodeCount,
    #episodeCount: _f$episodeCount,
    #hasUnseenEpisodes: _f$hasUnseenEpisodes,
  };

  static PodcastWithStatus _instantiate(DecodingData data) {
    return PodcastWithStatus(
      podcast: data.dec(_f$podcast),
      playedEpisodeCount: data.dec(_f$playedEpisodeCount),
      episodeCount: data.dec(_f$episodeCount),
      hasUnseenEpisodes: data.dec(_f$hasUnseenEpisodes),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PodcastWithStatus fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PodcastWithStatus>(map);
  }

  static PodcastWithStatus fromJson(String json) {
    return ensureInitialized().decodeJson<PodcastWithStatus>(json);
  }
}

mixin PodcastWithStatusMappable {
  String toJson() {
    return PodcastWithStatusMapper.ensureInitialized()
        .encodeJson<PodcastWithStatus>(this as PodcastWithStatus);
  }

  Map<String, dynamic> toMap() {
    return PodcastWithStatusMapper.ensureInitialized()
        .encodeMap<PodcastWithStatus>(this as PodcastWithStatus);
  }

  PodcastWithStatusCopyWith<
    PodcastWithStatus,
    PodcastWithStatus,
    PodcastWithStatus
  >
  get copyWith =>
      _PodcastWithStatusCopyWithImpl<PodcastWithStatus, PodcastWithStatus>(
        this as PodcastWithStatus,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PodcastWithStatusMapper.ensureInitialized().stringifyValue(
      this as PodcastWithStatus,
    );
  }

  @override
  bool operator ==(Object other) {
    return PodcastWithStatusMapper.ensureInitialized().equalsValue(
      this as PodcastWithStatus,
      other,
    );
  }

  @override
  int get hashCode {
    return PodcastWithStatusMapper.ensureInitialized().hashValue(
      this as PodcastWithStatus,
    );
  }
}

extension PodcastWithStatusValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PodcastWithStatus, $Out> {
  PodcastWithStatusCopyWith<$R, PodcastWithStatus, $Out>
  get $asPodcastWithStatus => $base.as(
    (v, t, t2) => _PodcastWithStatusCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PodcastWithStatusCopyWith<
  $R,
  $In extends PodcastWithStatus,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    Podcast? podcast,
    int? playedEpisodeCount,
    int? episodeCount,
    bool? hasUnseenEpisodes,
  });
  PodcastWithStatusCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PodcastWithStatusCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PodcastWithStatus, $Out>
    implements PodcastWithStatusCopyWith<$R, PodcastWithStatus, $Out> {
  _PodcastWithStatusCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PodcastWithStatus> $mapper =
      PodcastWithStatusMapper.ensureInitialized();
  @override
  $R call({
    Podcast? podcast,
    int? playedEpisodeCount,
    int? episodeCount,
    bool? hasUnseenEpisodes,
  }) => $apply(
    FieldCopyWithData({
      if (podcast != null) #podcast: podcast,
      if (playedEpisodeCount != null) #playedEpisodeCount: playedEpisodeCount,
      if (episodeCount != null) #episodeCount: episodeCount,
      if (hasUnseenEpisodes != null) #hasUnseenEpisodes: hasUnseenEpisodes,
    }),
  );
  @override
  PodcastWithStatus $make(CopyWithData data) => PodcastWithStatus(
    podcast: data.get(#podcast, or: $value.podcast),
    playedEpisodeCount: data.get(
      #playedEpisodeCount,
      or: $value.playedEpisodeCount,
    ),
    episodeCount: data.get(#episodeCount, or: $value.episodeCount),
    hasUnseenEpisodes: data.get(
      #hasUnseenEpisodes,
      or: $value.hasUnseenEpisodes,
    ),
  );

  @override
  PodcastWithStatusCopyWith<$R2, PodcastWithStatus, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PodcastWithStatusCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

