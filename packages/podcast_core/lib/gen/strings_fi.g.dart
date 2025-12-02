///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsFi with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFi({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fi,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fi>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsFi _root = this; // ignore: unused_field

	@override 
	TranslationsFi $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFi(meta: meta ?? this.$meta);

	// Translations
	@override String get ok => 'Ok';
	@override late final _TranslationsAddPodcastDialogFi addPodcastDialog = _TranslationsAddPodcastDialogFi._(_root);
	@override late final _TranslationsImportListenedEpisodesDialogFi importListenedEpisodesDialog = _TranslationsImportListenedEpisodesDialogFi._(_root);
	@override late final _TranslationsErrorScreenFi errorScreen = _TranslationsErrorScreenFi._(_root);
	@override late final _TranslationsLogOutDialogFi logOutDialog = _TranslationsLogOutDialogFi._(_root);
	@override late final _TranslationsEpisodeListItemFi episodeListItem = _TranslationsEpisodeListItemFi._(_root);
	@override late final _TranslationsEpisodeDetailsScreenFi episodeDetailsScreen = _TranslationsEpisodeDetailsScreenFi._(_root);
	@override late final _TranslationsPlayEpisodeButtonFi playEpisodeButton = _TranslationsPlayEpisodeButtonFi._(_root);
	@override late final _TranslationsPodcastDetailsScreenFi podcastDetailsScreen = _TranslationsPodcastDetailsScreenFi._(_root);
	@override late final _TranslationsPodcastSearchScreenFi podcastSearchScreen = _TranslationsPodcastSearchScreenFi._(_root);
	@override late final _TranslationsEpisodePlayerModalFi episodePlayerModal = _TranslationsEpisodePlayerModalFi._(_root);
	@override late final _TranslationsCurrentlyPlayingInformationFi currentlyPlayingInformation = _TranslationsCurrentlyPlayingInformationFi._(_root);
	@override late final _TranslationsFilterEpisodesPopupFi filterEpisodesPopup = _TranslationsFilterEpisodesPopupFi._(_root);
	@override late final _TranslationsMediaEventsFi mediaEvents = _TranslationsMediaEventsFi._(_root);
	@override late final _TranslationsMediaPlayerFi mediaPlayer = _TranslationsMediaPlayerFi._(_root);
	@override late final _TranslationsPodcastDetailsFi podcastDetails = _TranslationsPodcastDetailsFi._(_root);
	@override late final _TranslationsSettingsFi settings = _TranslationsSettingsFi._(_root);
	@override late final _TranslationsSmallMediaPlayerFi smallMediaPlayer = _TranslationsSmallMediaPlayerFi._(_root);
	@override late final _TranslationsExitDialogFi exitDialog = _TranslationsExitDialogFi._(_root);
	@override late final _TranslationsQueueFi queue = _TranslationsQueueFi._(_root);
}

// Path: addPodcastDialog
class _TranslationsAddPodcastDialogFi implements TranslationsAddPodcastDialogEn {
	_TranslationsAddPodcastDialogFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lisää podcast RSS-syötteellä';
	@override String get textFieldHint => 'Rss-url';
}

// Path: importListenedEpisodesDialog
class _TranslationsImportListenedEpisodesDialogFi implements TranslationsImportListenedEpisodesDialogEn {
	_TranslationsImportListenedEpisodesDialogFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tuo kuunnellut jaksot';
	@override String get textFieldHint => 'Kuunneltujen jaksojen JSON-url';
}

// Path: errorScreen
class _TranslationsErrorScreenFi implements TranslationsErrorScreenEn {
	_TranslationsErrorScreenFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get somethingWentWrong => 'Jotain meni pieleen.';
	@override String get tryReloading => 'Yritä ladata sivu uudelleen';
}

// Path: logOutDialog
class _TranslationsLogOutDialogFi implements TranslationsLogOutDialogEn {
	_TranslationsLogOutDialogFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kirjaudu ulos?';
	@override String get content => 'Jos kirjaudut ulos, sinun on kirjauduttava uudelleen sisään.';
	@override String get stayLoggedIn => 'Pysy kirjautuneena';
	@override String get logOut => 'Kirjaudu ulos';
}

// Path: episodeListItem
class _TranslationsEpisodeListItemFi implements TranslationsEpisodeListItemEn {
	_TranslationsEpisodeListItemFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get imageSemanticLabel => 'Jakson kuva';
	@override String get played => 'Toistettu jakso';
	@override String get unplayed => 'Toistamaton jakso';
	@override String duration({required Object duration}) => ' • ${duration}';
}

// Path: episodeDetailsScreen
class _TranslationsEpisodeDetailsScreenFi implements TranslationsEpisodeDetailsScreenEn {
	_TranslationsEpisodeDetailsScreenFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get podcastTitle => 'Podcastin nimi';
	@override String get episodeTitle => 'Jakson nimi';
}

// Path: playEpisodeButton
class _TranslationsPlayEpisodeButtonFi implements TranslationsPlayEpisodeButtonEn {
	_TranslationsPlayEpisodeButtonFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String playEpisodeTooltip({required Object title}) => 'Toista jakso ${title}';
	@override String get playEpisodeSemanticLabel => 'Toista jakso';
}

// Path: podcastDetailsScreen
class _TranslationsPodcastDetailsScreenFi implements TranslationsPodcastDetailsScreenEn {
	_TranslationsPodcastDetailsScreenFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get episodes => 'Jaksot';
	@override String get markUnlistened => 'Merkitse kuuntelemattomaksi';
	@override String get markListened => 'Merkitse kuunnelluksi';
}

// Path: podcastSearchScreen
class _TranslationsPodcastSearchScreenFi implements TranslationsPodcastSearchScreenEn {
	_TranslationsPodcastSearchScreenFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get searchForPodcasts => 'Etsi podcasteja';
	@override String get somethingWentWrong => 'Jotain meni pieleen.\nLähetä virheraportti osoitteeseen podcast@lohnn.se hakusanallasi.';
	@override String get podcastArtwork => 'Podcastin kansikuva';
}

// Path: episodePlayerModal
class _TranslationsEpisodePlayerModalFi implements TranslationsEpisodePlayerModalEn {
	_TranslationsEpisodePlayerModalFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get episodeImage => 'Jakson kuva';
	@override String get showPlaylist => 'Näytä soittolista';
}

// Path: currentlyPlayingInformation
class _TranslationsCurrentlyPlayingInformationFi implements TranslationsCurrentlyPlayingInformationEn {
	_TranslationsCurrentlyPlayingInformationFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get showPlaylist => 'Näytä soittolista';
	@override String get inYourQueue => 'Jonossasi:';
}

// Path: filterEpisodesPopup
class _TranslationsFilterEpisodesPopupFi implements TranslationsFilterEpisodesPopupEn {
	_TranslationsFilterEpisodesPopupFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get filterEpisodes => 'Suodata jaksoja';
	@override String get clearAllFilters => 'Poista kaikki suodattimet';
	@override String get hidePlayedEpisodes => 'Piilota toistetut jaksot';
	@override String get sortBy => 'Järjestä';
	@override String get changeSortOrder => 'Vaihda järjestystä';
	@override String get sortAscending => 'Järjestä nousevasti';
	@override String get sortDescending => 'Järjestä laskevasti';
}

// Path: mediaEvents
class _TranslationsMediaEventsFi implements TranslationsMediaEventsEn {
	_TranslationsMediaEventsFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get rewind => 'Kelaa taaksepäin';
	@override String get fastForward => 'Kelaa eteenpäin';
}

// Path: mediaPlayer
class _TranslationsMediaPlayerFi implements TranslationsMediaPlayerEn {
	_TranslationsMediaPlayerFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get play => 'Toista';
	@override String get pause => 'Tauko';
	@override String get rewind10 => 'Kelaa 10 sekuntia taaksepäin';
	@override String get rewind5 => 'Kelaa 5 sekuntia taaksepäin';
	@override String get rewind30 => 'Kelaa 30 sekuntia taaksepäin';
	@override String get forward10 => 'Hyppää 10 sekuntia eteenpäin';
	@override String get forward5 => 'Hyppää 5 sekuntia eteenpäin';
	@override String get forward30 => 'Hyppää 30 sekuntia eteenpäin';
}

// Path: podcastDetails
class _TranslationsPodcastDetailsFi implements TranslationsPodcastDetailsEn {
	_TranslationsPodcastDetailsFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get podcastImage => 'Podcastin kuva';
	@override String get rssFeed => 'Rss-syöte';
	@override String get expandDescription => 'Laajenna kuvaus';
	@override String get showLess => 'Näytä vähemmän';
	@override String get showMore => 'Näytä lisää';
	@override String get loading => 'Ladataan...';
	@override String get areYouSureToUnsubscribe => 'Haluatko varmasti lopettaa tilauksen?';
	@override String get yes => 'Kyllä';
	@override String get no => 'Ei';
	@override String get unsubscribe => 'Lopeta tilaus';
	@override String get addPodcast => 'Lisää podcast';
}

// Path: settings
class _TranslationsSettingsFi implements TranslationsSettingsEn {
	_TranslationsSettingsFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Asetukset';
}

// Path: smallMediaPlayer
class _TranslationsSmallMediaPlayerFi implements TranslationsSmallMediaPlayerEn {
	_TranslationsSmallMediaPlayerFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get errorLoadingEpisode => 'Virhe ladattaessa jaksoa';
	@override String get nothingIsPlaying => 'Mitään ei toisteta juuri nyt';
}

// Path: exitDialog
class _TranslationsExitDialogFi implements TranslationsExitDialogEn {
	_TranslationsExitDialogFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Haluatko varmasti poistua?';
	@override String get yes => 'Kyllä';
	@override String get no => 'Ei';
}

// Path: queue
class _TranslationsQueueFi implements TranslationsQueueEn {
	_TranslationsQueueFi._(this._root);

	final TranslationsFi _root; // ignore: unused_field

	// Translations
	@override String get addToQueue => 'Lisää jonoon';
	@override String get removeFromQueue => 'Poista jonosta';
}

/// The flat map containing all translations for locale <fi>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFi {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'ok' => 'Ok',
			'addPodcastDialog.title' => 'Lisää podcast RSS-syötteellä',
			'addPodcastDialog.textFieldHint' => 'Rss-url',
			'importListenedEpisodesDialog.title' => 'Tuo kuunnellut jaksot',
			'importListenedEpisodesDialog.textFieldHint' => 'Kuunneltujen jaksojen JSON-url',
			'errorScreen.somethingWentWrong' => 'Jotain meni pieleen.',
			'errorScreen.tryReloading' => 'Yritä ladata sivu uudelleen',
			'logOutDialog.title' => 'Kirjaudu ulos?',
			'logOutDialog.content' => 'Jos kirjaudut ulos, sinun on kirjauduttava uudelleen sisään.',
			'logOutDialog.stayLoggedIn' => 'Pysy kirjautuneena',
			'logOutDialog.logOut' => 'Kirjaudu ulos',
			'episodeListItem.imageSemanticLabel' => 'Jakson kuva',
			'episodeListItem.played' => 'Toistettu jakso',
			'episodeListItem.unplayed' => 'Toistamaton jakso',
			'episodeListItem.duration' => ({required Object duration}) => ' • ${duration}',
			'episodeDetailsScreen.podcastTitle' => 'Podcastin nimi',
			'episodeDetailsScreen.episodeTitle' => 'Jakson nimi',
			'playEpisodeButton.playEpisodeTooltip' => ({required Object title}) => 'Toista jakso ${title}',
			'playEpisodeButton.playEpisodeSemanticLabel' => 'Toista jakso',
			'podcastDetailsScreen.episodes' => 'Jaksot',
			'podcastDetailsScreen.markUnlistened' => 'Merkitse kuuntelemattomaksi',
			'podcastDetailsScreen.markListened' => 'Merkitse kuunnelluksi',
			'podcastSearchScreen.searchForPodcasts' => 'Etsi podcasteja',
			'podcastSearchScreen.somethingWentWrong' => 'Jotain meni pieleen.\nLähetä virheraportti osoitteeseen podcast@lohnn.se hakusanallasi.',
			'podcastSearchScreen.podcastArtwork' => 'Podcastin kansikuva',
			'episodePlayerModal.episodeImage' => 'Jakson kuva',
			'episodePlayerModal.showPlaylist' => 'Näytä soittolista',
			'currentlyPlayingInformation.showPlaylist' => 'Näytä soittolista',
			'currentlyPlayingInformation.inYourQueue' => 'Jonossasi:',
			'filterEpisodesPopup.filterEpisodes' => 'Suodata jaksoja',
			'filterEpisodesPopup.clearAllFilters' => 'Poista kaikki suodattimet',
			'filterEpisodesPopup.hidePlayedEpisodes' => 'Piilota toistetut jaksot',
			'filterEpisodesPopup.sortBy' => 'Järjestä',
			'filterEpisodesPopup.changeSortOrder' => 'Vaihda järjestystä',
			'filterEpisodesPopup.sortAscending' => 'Järjestä nousevasti',
			'filterEpisodesPopup.sortDescending' => 'Järjestä laskevasti',
			'mediaEvents.rewind' => 'Kelaa taaksepäin',
			'mediaEvents.fastForward' => 'Kelaa eteenpäin',
			'mediaPlayer.play' => 'Toista',
			'mediaPlayer.pause' => 'Tauko',
			'mediaPlayer.rewind10' => 'Kelaa 10 sekuntia taaksepäin',
			'mediaPlayer.rewind5' => 'Kelaa 5 sekuntia taaksepäin',
			'mediaPlayer.rewind30' => 'Kelaa 30 sekuntia taaksepäin',
			'mediaPlayer.forward10' => 'Hyppää 10 sekuntia eteenpäin',
			'mediaPlayer.forward5' => 'Hyppää 5 sekuntia eteenpäin',
			'mediaPlayer.forward30' => 'Hyppää 30 sekuntia eteenpäin',
			'podcastDetails.podcastImage' => 'Podcastin kuva',
			'podcastDetails.rssFeed' => 'Rss-syöte',
			'podcastDetails.expandDescription' => 'Laajenna kuvaus',
			'podcastDetails.showLess' => 'Näytä vähemmän',
			'podcastDetails.showMore' => 'Näytä lisää',
			'podcastDetails.loading' => 'Ladataan...',
			'podcastDetails.areYouSureToUnsubscribe' => 'Haluatko varmasti lopettaa tilauksen?',
			'podcastDetails.yes' => 'Kyllä',
			'podcastDetails.no' => 'Ei',
			'podcastDetails.unsubscribe' => 'Lopeta tilaus',
			'podcastDetails.addPodcast' => 'Lisää podcast',
			'settings.title' => 'Asetukset',
			'smallMediaPlayer.errorLoadingEpisode' => 'Virhe ladattaessa jaksoa',
			'smallMediaPlayer.nothingIsPlaying' => 'Mitään ei toisteta juuri nyt',
			'exitDialog.title' => 'Haluatko varmasti poistua?',
			'exitDialog.yes' => 'Kyllä',
			'exitDialog.no' => 'Ei',
			'queue.addToQueue' => 'Lisää jonoon',
			'queue.removeFromQueue' => 'Poista jonosta',
			_ => null,
		};
	}
}
