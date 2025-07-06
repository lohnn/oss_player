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
class TranslationsSv implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsSv({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.sv,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <sv>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsSv _root = this; // ignore: unused_field

	@override 
	TranslationsSv $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsSv(meta: meta ?? this.$meta);

	// Translations
	@override String get ok => 'Ok';
	@override late final _TranslationsAddPodcastDialogSv addPodcastDialog = _TranslationsAddPodcastDialogSv._(_root);
	@override late final _TranslationsImportListenedEpisodesDialogSv importListenedEpisodesDialog = _TranslationsImportListenedEpisodesDialogSv._(_root);
	@override late final _TranslationsErrorScreenSv errorScreen = _TranslationsErrorScreenSv._(_root);
	@override late final _TranslationsLogOutDialogSv logOutDialog = _TranslationsLogOutDialogSv._(_root);
	@override late final _TranslationsEpisodeListItemSv episodeListItem = _TranslationsEpisodeListItemSv._(_root);
	@override late final _TranslationsEpisodeDetailsScreenSv episodeDetailsScreen = _TranslationsEpisodeDetailsScreenSv._(_root);
	@override late final _TranslationsPlayEpisodeButtonSv playEpisodeButton = _TranslationsPlayEpisodeButtonSv._(_root);
	@override late final _TranslationsPodcastDetailsScreenSv podcastDetailsScreen = _TranslationsPodcastDetailsScreenSv._(_root);
	@override late final _TranslationsPodcastSearchScreenSv podcastSearchScreen = _TranslationsPodcastSearchScreenSv._(_root);
	@override late final _TranslationsEpisodePlayerModalSv episodePlayerModal = _TranslationsEpisodePlayerModalSv._(_root);
	@override late final _TranslationsCurrentlyPlayingInformationSv currentlyPlayingInformation = _TranslationsCurrentlyPlayingInformationSv._(_root);
	@override late final _TranslationsFilterEpisodesPopupSv filterEpisodesPopup = _TranslationsFilterEpisodesPopupSv._(_root);
	@override late final _TranslationsMediaEventsSv mediaEvents = _TranslationsMediaEventsSv._(_root);
	@override late final _TranslationsMediaPlayerSv mediaPlayer = _TranslationsMediaPlayerSv._(_root);
	@override late final _TranslationsPodcastDetailsSv podcastDetails = _TranslationsPodcastDetailsSv._(_root);
	@override late final _TranslationsSettingsSv settings = _TranslationsSettingsSv._(_root);
	@override late final _TranslationsSmallMediaPlayerSv smallMediaPlayer = _TranslationsSmallMediaPlayerSv._(_root);
	@override late final _TranslationsExitDialogSv exitDialog = _TranslationsExitDialogSv._(_root);
	@override late final _TranslationsQueueSv queue = _TranslationsQueueSv._(_root);
}

// Path: addPodcastDialog
class _TranslationsAddPodcastDialogSv implements TranslationsAddPodcastDialogEn {
	_TranslationsAddPodcastDialogSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lägg till podd via RSS';
	@override String get textFieldHint => 'Rss-url';
}

// Path: importListenedEpisodesDialog
class _TranslationsImportListenedEpisodesDialogSv implements TranslationsImportListenedEpisodesDialogEn {
	_TranslationsImportListenedEpisodesDialogSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get title => 'Importera lyssnade avsnitt';
	@override String get textFieldHint => 'JSON-url för lyssnade avsnitt';
}

// Path: errorScreen
class _TranslationsErrorScreenSv implements TranslationsErrorScreenEn {
	_TranslationsErrorScreenSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get somethingWentWrong => 'Något gick fel.';
	@override String get tryReloading => 'Försök att ladda om sidan';
}

// Path: logOutDialog
class _TranslationsLogOutDialogSv implements TranslationsLogOutDialogEn {
	_TranslationsLogOutDialogSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get title => 'Logga ut?';
	@override String get content => 'Om du loggar ut måste du logga in igen.';
	@override String get stayLoggedIn => 'Förbli inloggad';
	@override String get logOut => 'Logga ut';
}

// Path: episodeListItem
class _TranslationsEpisodeListItemSv implements TranslationsEpisodeListItemEn {
	_TranslationsEpisodeListItemSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get imageSemanticLabel => 'Avsnittsbild';
	@override String get played => 'Spelat avsnitt';
	@override String get unplayed => 'Ospelat avsnitt';
	@override String duration({required Object duration}) => ' • ${duration}';
}

// Path: episodeDetailsScreen
class _TranslationsEpisodeDetailsScreenSv implements TranslationsEpisodeDetailsScreenEn {
	_TranslationsEpisodeDetailsScreenSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get podcastTitle => 'Poddtitel';
	@override String get episodeTitle => 'Avsnittstitel';
}

// Path: playEpisodeButton
class _TranslationsPlayEpisodeButtonSv implements TranslationsPlayEpisodeButtonEn {
	_TranslationsPlayEpisodeButtonSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String playEpisodeTooltip({required Object title}) => 'Spela avsnitt ${title}';
	@override String get playEpisodeSemanticLabel => 'Spela avsnitt';
}

// Path: podcastDetailsScreen
class _TranslationsPodcastDetailsScreenSv implements TranslationsPodcastDetailsScreenEn {
	_TranslationsPodcastDetailsScreenSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get episodes => 'Avsnitt';
	@override String get markUnlistened => 'Markera som olyssnad';
	@override String get markListened => 'Markera som lyssnad';
}

// Path: podcastSearchScreen
class _TranslationsPodcastSearchScreenSv implements TranslationsPodcastSearchScreenEn {
	_TranslationsPodcastSearchScreenSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get searchForPodcasts => 'Sök efter poddar';
	@override String get somethingWentWrong => 'Något gick fel.\nSkicka en felrapport till podcast@lohnn.se med din sökterm.';
	@override String get podcastArtwork => 'Poddbild';
}

// Path: episodePlayerModal
class _TranslationsEpisodePlayerModalSv implements TranslationsEpisodePlayerModalEn {
	_TranslationsEpisodePlayerModalSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get episodeImage => 'Avsnittsbild';
	@override String get showPlaylist => 'Visa spellista';
}

// Path: currentlyPlayingInformation
class _TranslationsCurrentlyPlayingInformationSv implements TranslationsCurrentlyPlayingInformationEn {
	_TranslationsCurrentlyPlayingInformationSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get showPlaylist => 'Visa spellista';
	@override String get inYourQueue => 'I din kö:';
}

// Path: filterEpisodesPopup
class _TranslationsFilterEpisodesPopupSv implements TranslationsFilterEpisodesPopupEn {
	_TranslationsFilterEpisodesPopupSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get filterEpisodes => 'Filtrera avsnitt';
	@override String get clearAllFilters => 'Rensa alla filter';
	@override String get hidePlayedEpisodes => 'Dölj spelade avsnitt';
	@override String get sortBy => 'Sortera efter';
	@override String get changeSortOrder => 'Ändra sorteringsordning';
	@override String get sortAscending => 'Sortera stigande';
	@override String get sortDescending => 'Sortera fallande';
}

// Path: mediaEvents
class _TranslationsMediaEventsSv implements TranslationsMediaEventsEn {
	_TranslationsMediaEventsSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get rewind => 'Spola tillbaka';
	@override String get fastForward => 'Spola framåt';
}

// Path: mediaPlayer
class _TranslationsMediaPlayerSv implements TranslationsMediaPlayerEn {
	_TranslationsMediaPlayerSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get play => 'Spela';
	@override String get pause => 'Pausa';
	@override String get rewind10 => 'Spola tillbaka 10 sekunder';
	@override String get rewind5 => 'Spola tillbaka 5 sekunder';
	@override String get rewind30 => 'Spola tillbaka 30 sekunder';
	@override String get forward10 => 'Hoppa framåt 10 sekunder';
	@override String get forward5 => 'Hoppa framåt 5 sekunder';
	@override String get forward30 => 'Hoppa framåt 30 sekunder';
}

// Path: podcastDetails
class _TranslationsPodcastDetailsSv implements TranslationsPodcastDetailsEn {
	_TranslationsPodcastDetailsSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get podcastImage => 'Poddbild';
	@override String get rssFeed => 'Rss-flöde';
	@override String get expandDescription => 'Visa mer';
	@override String get showLess => 'Visa mindre';
	@override String get showMore => 'Visa mer';
	@override String get loading => 'Laddar...';
	@override String get areYouSureToUnsubscribe => 'Är du säker på att du vill avprenumerera?';
	@override String get yes => 'Ja';
	@override String get no => 'Nej';
	@override String get unsubscribe => 'Avprenumerera';
	@override String get addPodcast => 'Lägg till podd';
}

// Path: settings
class _TranslationsSettingsSv implements TranslationsSettingsEn {
	_TranslationsSettingsSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get title => 'Inställningar';
}

// Path: smallMediaPlayer
class _TranslationsSmallMediaPlayerSv implements TranslationsSmallMediaPlayerEn {
	_TranslationsSmallMediaPlayerSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get errorLoadingEpisode => 'Fel vid laddning av avsnitt';
	@override String get nothingIsPlaying => 'Inget spelas just nu';
}

// Path: exitDialog
class _TranslationsExitDialogSv implements TranslationsExitDialogEn {
	_TranslationsExitDialogSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get title => 'Är du säker på att du vill avsluta?';
	@override String get yes => 'Ja';
	@override String get no => 'Nej';
}

// Path: queue
class _TranslationsQueueSv implements TranslationsQueueEn {
	_TranslationsQueueSv._(this._root);

	final TranslationsSv _root; // ignore: unused_field

	// Translations
	@override String get addToQueue => 'Lägg till i kö';
	@override String get removeFromQueue => 'Ta bort från kö';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsSv {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'ok': return 'Ok';
			case 'addPodcastDialog.title': return 'Lägg till podd via RSS';
			case 'addPodcastDialog.textFieldHint': return 'Rss-url';
			case 'importListenedEpisodesDialog.title': return 'Importera lyssnade avsnitt';
			case 'importListenedEpisodesDialog.textFieldHint': return 'JSON-url för lyssnade avsnitt';
			case 'errorScreen.somethingWentWrong': return 'Något gick fel.';
			case 'errorScreen.tryReloading': return 'Försök att ladda om sidan';
			case 'logOutDialog.title': return 'Logga ut?';
			case 'logOutDialog.content': return 'Om du loggar ut måste du logga in igen.';
			case 'logOutDialog.stayLoggedIn': return 'Förbli inloggad';
			case 'logOutDialog.logOut': return 'Logga ut';
			case 'episodeListItem.imageSemanticLabel': return 'Avsnittsbild';
			case 'episodeListItem.played': return 'Spelat avsnitt';
			case 'episodeListItem.unplayed': return 'Ospelat avsnitt';
			case 'episodeListItem.duration': return ({required Object duration}) => ' • ${duration}';
			case 'episodeDetailsScreen.podcastTitle': return 'Poddtitel';
			case 'episodeDetailsScreen.episodeTitle': return 'Avsnittstitel';
			case 'playEpisodeButton.playEpisodeTooltip': return ({required Object title}) => 'Spela avsnitt ${title}';
			case 'playEpisodeButton.playEpisodeSemanticLabel': return 'Spela avsnitt';
			case 'podcastDetailsScreen.episodes': return 'Avsnitt';
			case 'podcastDetailsScreen.markUnlistened': return 'Markera som olyssnad';
			case 'podcastDetailsScreen.markListened': return 'Markera som lyssnad';
			case 'podcastSearchScreen.searchForPodcasts': return 'Sök efter poddar';
			case 'podcastSearchScreen.somethingWentWrong': return 'Något gick fel.\nSkicka en felrapport till podcast@lohnn.se med din sökterm.';
			case 'podcastSearchScreen.podcastArtwork': return 'Poddbild';
			case 'episodePlayerModal.episodeImage': return 'Avsnittsbild';
			case 'episodePlayerModal.showPlaylist': return 'Visa spellista';
			case 'currentlyPlayingInformation.showPlaylist': return 'Visa spellista';
			case 'currentlyPlayingInformation.inYourQueue': return 'I din kö:';
			case 'filterEpisodesPopup.filterEpisodes': return 'Filtrera avsnitt';
			case 'filterEpisodesPopup.clearAllFilters': return 'Rensa alla filter';
			case 'filterEpisodesPopup.hidePlayedEpisodes': return 'Dölj spelade avsnitt';
			case 'filterEpisodesPopup.sortBy': return 'Sortera efter';
			case 'filterEpisodesPopup.changeSortOrder': return 'Ändra sorteringsordning';
			case 'filterEpisodesPopup.sortAscending': return 'Sortera stigande';
			case 'filterEpisodesPopup.sortDescending': return 'Sortera fallande';
			case 'mediaEvents.rewind': return 'Spola tillbaka';
			case 'mediaEvents.fastForward': return 'Spola framåt';
			case 'mediaPlayer.play': return 'Spela';
			case 'mediaPlayer.pause': return 'Pausa';
			case 'mediaPlayer.rewind10': return 'Spola tillbaka 10 sekunder';
			case 'mediaPlayer.rewind5': return 'Spola tillbaka 5 sekunder';
			case 'mediaPlayer.rewind30': return 'Spola tillbaka 30 sekunder';
			case 'mediaPlayer.forward10': return 'Hoppa framåt 10 sekunder';
			case 'mediaPlayer.forward5': return 'Hoppa framåt 5 sekunder';
			case 'mediaPlayer.forward30': return 'Hoppa framåt 30 sekunder';
			case 'podcastDetails.podcastImage': return 'Poddbild';
			case 'podcastDetails.rssFeed': return 'Rss-flöde';
			case 'podcastDetails.expandDescription': return 'Visa mer';
			case 'podcastDetails.showLess': return 'Visa mindre';
			case 'podcastDetails.showMore': return 'Visa mer';
			case 'podcastDetails.loading': return 'Laddar...';
			case 'podcastDetails.areYouSureToUnsubscribe': return 'Är du säker på att du vill avprenumerera?';
			case 'podcastDetails.yes': return 'Ja';
			case 'podcastDetails.no': return 'Nej';
			case 'podcastDetails.unsubscribe': return 'Avprenumerera';
			case 'podcastDetails.addPodcast': return 'Lägg till podd';
			case 'settings.title': return 'Inställningar';
			case 'smallMediaPlayer.errorLoadingEpisode': return 'Fel vid laddning av avsnitt';
			case 'smallMediaPlayer.nothingIsPlaying': return 'Inget spelas just nu';
			case 'exitDialog.title': return 'Är du säker på att du vill avsluta?';
			case 'exitDialog.yes': return 'Ja';
			case 'exitDialog.no': return 'Nej';
			case 'queue.addToQueue': return 'Lägg till i kö';
			case 'queue.removeFromQueue': return 'Ta bort från kö';
			default: return null;
		}
	}
}

