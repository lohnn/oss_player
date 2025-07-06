///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsFi implements Translations {
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

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsFi {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'ok': return 'Ok';
			case 'addPodcastDialog.title': return 'Lisää podcast RSS-syötteellä';
			case 'addPodcastDialog.textFieldHint': return 'Rss-url';
			case 'importListenedEpisodesDialog.title': return 'Tuo kuunnellut jaksot';
			case 'importListenedEpisodesDialog.textFieldHint': return 'Kuunneltujen jaksojen JSON-url';
			case 'errorScreen.somethingWentWrong': return 'Jotain meni pieleen.';
			case 'errorScreen.tryReloading': return 'Yritä ladata sivu uudelleen';
			case 'logOutDialog.title': return 'Kirjaudu ulos?';
			case 'logOutDialog.content': return 'Jos kirjaudut ulos, sinun on kirjauduttava uudelleen sisään.';
			case 'logOutDialog.stayLoggedIn': return 'Pysy kirjautuneena';
			case 'logOutDialog.logOut': return 'Kirjaudu ulos';
			case 'episodeListItem.imageSemanticLabel': return 'Jakson kuva';
			case 'episodeListItem.played': return 'Toistettu jakso';
			case 'episodeListItem.unplayed': return 'Toistamaton jakso';
			case 'episodeListItem.duration': return ({required Object duration}) => ' • ${duration}';
			case 'episodeDetailsScreen.podcastTitle': return 'Podcastin nimi';
			case 'episodeDetailsScreen.episodeTitle': return 'Jakson nimi';
			case 'playEpisodeButton.playEpisodeTooltip': return ({required Object title}) => 'Toista jakso ${title}';
			case 'playEpisodeButton.playEpisodeSemanticLabel': return 'Toista jakso';
			case 'podcastDetailsScreen.episodes': return 'Jaksot';
			case 'podcastDetailsScreen.markUnlistened': return 'Merkitse kuuntelemattomaksi';
			case 'podcastDetailsScreen.markListened': return 'Merkitse kuunnelluksi';
			case 'podcastSearchScreen.searchForPodcasts': return 'Etsi podcasteja';
			case 'podcastSearchScreen.somethingWentWrong': return 'Jotain meni pieleen.\nLähetä virheraportti osoitteeseen podcast@lohnn.se hakusanallasi.';
			case 'podcastSearchScreen.podcastArtwork': return 'Podcastin kansikuva';
			case 'episodePlayerModal.episodeImage': return 'Jakson kuva';
			case 'episodePlayerModal.showPlaylist': return 'Näytä soittolista';
			case 'currentlyPlayingInformation.showPlaylist': return 'Näytä soittolista';
			case 'currentlyPlayingInformation.inYourQueue': return 'Jonossasi:';
			case 'filterEpisodesPopup.filterEpisodes': return 'Suodata jaksoja';
			case 'filterEpisodesPopup.clearAllFilters': return 'Poista kaikki suodattimet';
			case 'filterEpisodesPopup.hidePlayedEpisodes': return 'Piilota toistetut jaksot';
			case 'filterEpisodesPopup.sortBy': return 'Järjestä';
			case 'filterEpisodesPopup.changeSortOrder': return 'Vaihda järjestystä';
			case 'filterEpisodesPopup.sortAscending': return 'Järjestä nousevasti';
			case 'filterEpisodesPopup.sortDescending': return 'Järjestä laskevasti';
			case 'mediaEvents.rewind': return 'Kelaa taaksepäin';
			case 'mediaEvents.fastForward': return 'Kelaa eteenpäin';
			case 'mediaPlayer.play': return 'Toista';
			case 'mediaPlayer.pause': return 'Tauko';
			case 'mediaPlayer.rewind10': return 'Kelaa 10 sekuntia taaksepäin';
			case 'mediaPlayer.rewind5': return 'Kelaa 5 sekuntia taaksepäin';
			case 'mediaPlayer.rewind30': return 'Kelaa 30 sekuntia taaksepäin';
			case 'mediaPlayer.forward10': return 'Hyppää 10 sekuntia eteenpäin';
			case 'mediaPlayer.forward5': return 'Hyppää 5 sekuntia eteenpäin';
			case 'mediaPlayer.forward30': return 'Hyppää 30 sekuntia eteenpäin';
			case 'podcastDetails.podcastImage': return 'Podcastin kuva';
			case 'podcastDetails.rssFeed': return 'Rss-syöte';
			case 'podcastDetails.expandDescription': return 'Laajenna kuvaus';
			case 'podcastDetails.showLess': return 'Näytä vähemmän';
			case 'podcastDetails.showMore': return 'Näytä lisää';
			case 'podcastDetails.loading': return 'Ladataan...';
			case 'podcastDetails.areYouSureToUnsubscribe': return 'Haluatko varmasti lopettaa tilauksen?';
			case 'podcastDetails.yes': return 'Kyllä';
			case 'podcastDetails.no': return 'Ei';
			case 'podcastDetails.unsubscribe': return 'Lopeta tilaus';
			case 'podcastDetails.addPodcast': return 'Lisää podcast';
			case 'settings.title': return 'Asetukset';
			case 'smallMediaPlayer.errorLoadingEpisode': return 'Virhe ladattaessa jaksoa';
			case 'smallMediaPlayer.nothingIsPlaying': return 'Mitään ei toisteta juuri nyt';
			case 'exitDialog.title': return 'Haluatko varmasti poistua?';
			case 'exitDialog.yes': return 'Kyllä';
			case 'exitDialog.no': return 'Ei';
			case 'queue.addToQueue': return 'Lisää jonoon';
			case 'queue.removeFromQueue': return 'Poista jonosta';
			default: return null;
		}
	}
}

