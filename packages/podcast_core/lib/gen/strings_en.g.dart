///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'Ok'
	String get ok => 'Ok';

	late final TranslationsAddPodcastDialogEn addPodcastDialog = TranslationsAddPodcastDialogEn._(_root);
	late final TranslationsImportListenedEpisodesDialogEn importListenedEpisodesDialog = TranslationsImportListenedEpisodesDialogEn._(_root);
	late final TranslationsErrorScreenEn errorScreen = TranslationsErrorScreenEn._(_root);
	late final TranslationsLogOutDialogEn logOutDialog = TranslationsLogOutDialogEn._(_root);
	late final TranslationsEpisodeListItemEn episodeListItem = TranslationsEpisodeListItemEn._(_root);
	late final TranslationsEpisodeDetailsScreenEn episodeDetailsScreen = TranslationsEpisodeDetailsScreenEn._(_root);
	late final TranslationsPlayEpisodeButtonEn playEpisodeButton = TranslationsPlayEpisodeButtonEn._(_root);
	late final TranslationsPodcastDetailsScreenEn podcastDetailsScreen = TranslationsPodcastDetailsScreenEn._(_root);
	late final TranslationsPodcastSearchScreenEn podcastSearchScreen = TranslationsPodcastSearchScreenEn._(_root);
	late final TranslationsEpisodePlayerModalEn episodePlayerModal = TranslationsEpisodePlayerModalEn._(_root);
	late final TranslationsCurrentlyPlayingInformationEn currentlyPlayingInformation = TranslationsCurrentlyPlayingInformationEn._(_root);
	late final TranslationsFilterEpisodesPopupEn filterEpisodesPopup = TranslationsFilterEpisodesPopupEn._(_root);
	late final TranslationsMediaEventsEn mediaEvents = TranslationsMediaEventsEn._(_root);
	late final TranslationsMediaPlayerEn mediaPlayer = TranslationsMediaPlayerEn._(_root);
	late final TranslationsPodcastDetailsEn podcastDetails = TranslationsPodcastDetailsEn._(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
	late final TranslationsSmallMediaPlayerEn smallMediaPlayer = TranslationsSmallMediaPlayerEn._(_root);
	late final TranslationsExitDialogEn exitDialog = TranslationsExitDialogEn._(_root);
	late final TranslationsQueueEn queue = TranslationsQueueEn._(_root);
}

// Path: addPodcastDialog
class TranslationsAddPodcastDialogEn {
	TranslationsAddPodcastDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add podcast by RSS'
	String get title => 'Add podcast by RSS';

	/// en: 'Rss url'
	String get textFieldHint => 'Rss url';
}

// Path: importListenedEpisodesDialog
class TranslationsImportListenedEpisodesDialogEn {
	TranslationsImportListenedEpisodesDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Import listened episodes'
	String get title => 'Import listened episodes';

	/// en: 'Listened episodes JSON url'
	String get textFieldHint => 'Listened episodes JSON url';
}

// Path: errorScreen
class TranslationsErrorScreenEn {
	TranslationsErrorScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Something went wrong.'
	String get somethingWentWrong => 'Something went wrong.';

	/// en: 'Try reloading the page'
	String get tryReloading => 'Try reloading the page';
}

// Path: logOutDialog
class TranslationsLogOutDialogEn {
	TranslationsLogOutDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Log out?'
	String get title => 'Log out?';

	/// en: 'If you log out, you'll need to log in again.'
	String get content => 'If you log out, you\'ll need to log in again.';

	/// en: 'Stay logged in'
	String get stayLoggedIn => 'Stay logged in';

	/// en: 'Log out'
	String get logOut => 'Log out';
}

// Path: episodeListItem
class TranslationsEpisodeListItemEn {
	TranslationsEpisodeListItemEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Episode image'
	String get imageSemanticLabel => 'Episode image';

	/// en: 'Played episode'
	String get played => 'Played episode';

	/// en: 'Unplayed episode'
	String get unplayed => 'Unplayed episode';

	/// en: ' • ${duration}'
	String duration({required Object duration}) => ' • ${duration}';
}

// Path: episodeDetailsScreen
class TranslationsEpisodeDetailsScreenEn {
	TranslationsEpisodeDetailsScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Podcast Title'
	String get podcastTitle => 'Podcast Title';

	/// en: 'Episode Title'
	String get episodeTitle => 'Episode Title';
}

// Path: playEpisodeButton
class TranslationsPlayEpisodeButtonEn {
	TranslationsPlayEpisodeButtonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Play episode ${title}'
	String playEpisodeTooltip({required Object title}) => 'Play episode ${title}';

	/// en: 'Play episode'
	String get playEpisodeSemanticLabel => 'Play episode';
}

// Path: podcastDetailsScreen
class TranslationsPodcastDetailsScreenEn {
	TranslationsPodcastDetailsScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Episodes'
	String get episodes => 'Episodes';

	/// en: 'Mark unlistened'
	String get markUnlistened => 'Mark unlistened';

	/// en: 'Mark listened'
	String get markListened => 'Mark listened';
}

// Path: podcastSearchScreen
class TranslationsPodcastSearchScreenEn {
	TranslationsPodcastSearchScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search for podcasts'
	String get searchForPodcasts => 'Search for podcasts';

	/// en: 'Something went wrong. Please send an error report to podcast@lohnn.se with your search term.'
	String get somethingWentWrong => 'Something went wrong.\nPlease send an error report to podcast@lohnn.se with your search term.';

	/// en: 'Podcast artwork'
	String get podcastArtwork => 'Podcast artwork';
}

// Path: episodePlayerModal
class TranslationsEpisodePlayerModalEn {
	TranslationsEpisodePlayerModalEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Episode image'
	String get episodeImage => 'Episode image';

	/// en: 'Show playlist'
	String get showPlaylist => 'Show playlist';
}

// Path: currentlyPlayingInformation
class TranslationsCurrentlyPlayingInformationEn {
	TranslationsCurrentlyPlayingInformationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Show playlist'
	String get showPlaylist => 'Show playlist';

	/// en: 'In your queue:'
	String get inYourQueue => 'In your queue:';
}

// Path: filterEpisodesPopup
class TranslationsFilterEpisodesPopupEn {
	TranslationsFilterEpisodesPopupEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Filter episodes'
	String get filterEpisodes => 'Filter episodes';

	/// en: 'Clear all filters'
	String get clearAllFilters => 'Clear all filters';

	/// en: 'Hide played episodes'
	String get hidePlayedEpisodes => 'Hide played episodes';

	/// en: 'Sort by'
	String get sortBy => 'Sort by';

	/// en: 'Change sort order'
	String get changeSortOrder => 'Change sort order';

	/// en: 'Sort ascending'
	String get sortAscending => 'Sort ascending';

	/// en: 'Sort descending'
	String get sortDescending => 'Sort descending';
}

// Path: mediaEvents
class TranslationsMediaEventsEn {
	TranslationsMediaEventsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Rewind'
	String get rewind => 'Rewind';

	/// en: 'Fast forward'
	String get fastForward => 'Fast forward';
}

// Path: mediaPlayer
class TranslationsMediaPlayerEn {
	TranslationsMediaPlayerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Play'
	String get play => 'Play';

	/// en: 'Pause'
	String get pause => 'Pause';

	/// en: 'Rewind 10 seconds'
	String get rewind10 => 'Rewind 10 seconds';

	/// en: 'Rewind 5 seconds'
	String get rewind5 => 'Rewind 5 seconds';

	/// en: 'Rewind 30 seconds'
	String get rewind30 => 'Rewind 30 seconds';

	/// en: 'Skip forward 10 seconds'
	String get forward10 => 'Skip forward 10 seconds';

	/// en: 'Skip forward 5 seconds'
	String get forward5 => 'Skip forward 5 seconds';

	/// en: 'Skip forward 30 seconds'
	String get forward30 => 'Skip forward 30 seconds';
}

// Path: podcastDetails
class TranslationsPodcastDetailsEn {
	TranslationsPodcastDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Podcast image'
	String get podcastImage => 'Podcast image';

	/// en: 'Rss feed'
	String get rssFeed => 'Rss feed';

	/// en: 'Expand description'
	String get expandDescription => 'Expand description';

	/// en: 'Show less'
	String get showLess => 'Show less';

	/// en: 'Show more'
	String get showMore => 'Show more';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Are you sure you want to unsubscribe?'
	String get areYouSureToUnsubscribe => 'Are you sure you want to unsubscribe?';

	/// en: 'Yes'
	String get yes => 'Yes';

	/// en: 'No'
	String get no => 'No';

	/// en: 'Unsubscribe'
	String get unsubscribe => 'Unsubscribe';

	/// en: 'Add podcast'
	String get addPodcast => 'Add podcast';
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';
}

// Path: smallMediaPlayer
class TranslationsSmallMediaPlayerEn {
	TranslationsSmallMediaPlayerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error loading episode'
	String get errorLoadingEpisode => 'Error loading episode';

	/// en: 'Nothing is playing right now'
	String get nothingIsPlaying => 'Nothing is playing right now';
}

// Path: exitDialog
class TranslationsExitDialogEn {
	TranslationsExitDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Are you sure you want to exit?'
	String get title => 'Are you sure you want to exit?';

	/// en: 'Yes'
	String get yes => 'Yes';

	/// en: 'No'
	String get no => 'No';
}

// Path: queue
class TranslationsQueueEn {
	TranslationsQueueEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add to queue'
	String get addToQueue => 'Add to queue';

	/// en: 'Remove from queue'
	String get removeFromQueue => 'Remove from queue';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'ok' => 'Ok',
			'addPodcastDialog.title' => 'Add podcast by RSS',
			'addPodcastDialog.textFieldHint' => 'Rss url',
			'importListenedEpisodesDialog.title' => 'Import listened episodes',
			'importListenedEpisodesDialog.textFieldHint' => 'Listened episodes JSON url',
			'errorScreen.somethingWentWrong' => 'Something went wrong.',
			'errorScreen.tryReloading' => 'Try reloading the page',
			'logOutDialog.title' => 'Log out?',
			'logOutDialog.content' => 'If you log out, you\'ll need to log in again.',
			'logOutDialog.stayLoggedIn' => 'Stay logged in',
			'logOutDialog.logOut' => 'Log out',
			'episodeListItem.imageSemanticLabel' => 'Episode image',
			'episodeListItem.played' => 'Played episode',
			'episodeListItem.unplayed' => 'Unplayed episode',
			'episodeListItem.duration' => ({required Object duration}) => ' • ${duration}',
			'episodeDetailsScreen.podcastTitle' => 'Podcast Title',
			'episodeDetailsScreen.episodeTitle' => 'Episode Title',
			'playEpisodeButton.playEpisodeTooltip' => ({required Object title}) => 'Play episode ${title}',
			'playEpisodeButton.playEpisodeSemanticLabel' => 'Play episode',
			'podcastDetailsScreen.episodes' => 'Episodes',
			'podcastDetailsScreen.markUnlistened' => 'Mark unlistened',
			'podcastDetailsScreen.markListened' => 'Mark listened',
			'podcastSearchScreen.searchForPodcasts' => 'Search for podcasts',
			'podcastSearchScreen.somethingWentWrong' => 'Something went wrong.\nPlease send an error report to podcast@lohnn.se with your search term.',
			'podcastSearchScreen.podcastArtwork' => 'Podcast artwork',
			'episodePlayerModal.episodeImage' => 'Episode image',
			'episodePlayerModal.showPlaylist' => 'Show playlist',
			'currentlyPlayingInformation.showPlaylist' => 'Show playlist',
			'currentlyPlayingInformation.inYourQueue' => 'In your queue:',
			'filterEpisodesPopup.filterEpisodes' => 'Filter episodes',
			'filterEpisodesPopup.clearAllFilters' => 'Clear all filters',
			'filterEpisodesPopup.hidePlayedEpisodes' => 'Hide played episodes',
			'filterEpisodesPopup.sortBy' => 'Sort by',
			'filterEpisodesPopup.changeSortOrder' => 'Change sort order',
			'filterEpisodesPopup.sortAscending' => 'Sort ascending',
			'filterEpisodesPopup.sortDescending' => 'Sort descending',
			'mediaEvents.rewind' => 'Rewind',
			'mediaEvents.fastForward' => 'Fast forward',
			'mediaPlayer.play' => 'Play',
			'mediaPlayer.pause' => 'Pause',
			'mediaPlayer.rewind10' => 'Rewind 10 seconds',
			'mediaPlayer.rewind5' => 'Rewind 5 seconds',
			'mediaPlayer.rewind30' => 'Rewind 30 seconds',
			'mediaPlayer.forward10' => 'Skip forward 10 seconds',
			'mediaPlayer.forward5' => 'Skip forward 5 seconds',
			'mediaPlayer.forward30' => 'Skip forward 30 seconds',
			'podcastDetails.podcastImage' => 'Podcast image',
			'podcastDetails.rssFeed' => 'Rss feed',
			'podcastDetails.expandDescription' => 'Expand description',
			'podcastDetails.showLess' => 'Show less',
			'podcastDetails.showMore' => 'Show more',
			'podcastDetails.loading' => 'Loading...',
			'podcastDetails.areYouSureToUnsubscribe' => 'Are you sure you want to unsubscribe?',
			'podcastDetails.yes' => 'Yes',
			'podcastDetails.no' => 'No',
			'podcastDetails.unsubscribe' => 'Unsubscribe',
			'podcastDetails.addPodcast' => 'Add podcast',
			'settings.title' => 'Settings',
			'smallMediaPlayer.errorLoadingEpisode' => 'Error loading episode',
			'smallMediaPlayer.nothingIsPlaying' => 'Nothing is playing right now',
			'exitDialog.title' => 'Are you sure you want to exit?',
			'exitDialog.yes' => 'Yes',
			'exitDialog.no' => 'No',
			'queue.addToQueue' => 'Add to queue',
			'queue.removeFromQueue' => 'Remove from queue',
			_ => null,
		};
	}
}
