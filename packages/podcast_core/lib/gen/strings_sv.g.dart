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
class TranslationsSv with BaseTranslations<AppLocale, Translations> implements Translations {
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

/// The flat map containing all translations for locale <sv>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsSv {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'ok' => 'Ok',
			'addPodcastDialog.title' => 'Lägg till podd via RSS',
			'addPodcastDialog.textFieldHint' => 'Rss-url',
			'importListenedEpisodesDialog.title' => 'Importera lyssnade avsnitt',
			'importListenedEpisodesDialog.textFieldHint' => 'JSON-url för lyssnade avsnitt',
			'errorScreen.somethingWentWrong' => 'Något gick fel.',
			'errorScreen.tryReloading' => 'Försök att ladda om sidan',
			'logOutDialog.title' => 'Logga ut?',
			'logOutDialog.content' => 'Om du loggar ut måste du logga in igen.',
			'logOutDialog.stayLoggedIn' => 'Förbli inloggad',
			'logOutDialog.logOut' => 'Logga ut',
			'episodeListItem.imageSemanticLabel' => 'Avsnittsbild',
			'episodeListItem.played' => 'Spelat avsnitt',
			'episodeListItem.unplayed' => 'Ospelat avsnitt',
			'episodeListItem.duration' => ({required Object duration}) => ' • ${duration}',
			'episodeDetailsScreen.podcastTitle' => 'Poddtitel',
			'episodeDetailsScreen.episodeTitle' => 'Avsnittstitel',
			'playEpisodeButton.playEpisodeTooltip' => ({required Object title}) => 'Spela avsnitt ${title}',
			'playEpisodeButton.playEpisodeSemanticLabel' => 'Spela avsnitt',
			'podcastDetailsScreen.episodes' => 'Avsnitt',
			'podcastDetailsScreen.markUnlistened' => 'Markera som olyssnad',
			'podcastDetailsScreen.markListened' => 'Markera som lyssnad',
			'podcastSearchScreen.searchForPodcasts' => 'Sök efter poddar',
			'podcastSearchScreen.somethingWentWrong' => 'Något gick fel.\nSkicka en felrapport till podcast@lohnn.se med din sökterm.',
			'podcastSearchScreen.podcastArtwork' => 'Poddbild',
			'episodePlayerModal.episodeImage' => 'Avsnittsbild',
			'episodePlayerModal.showPlaylist' => 'Visa spellista',
			'currentlyPlayingInformation.showPlaylist' => 'Visa spellista',
			'currentlyPlayingInformation.inYourQueue' => 'I din kö:',
			'filterEpisodesPopup.filterEpisodes' => 'Filtrera avsnitt',
			'filterEpisodesPopup.clearAllFilters' => 'Rensa alla filter',
			'filterEpisodesPopup.hidePlayedEpisodes' => 'Dölj spelade avsnitt',
			'filterEpisodesPopup.sortBy' => 'Sortera efter',
			'filterEpisodesPopup.changeSortOrder' => 'Ändra sorteringsordning',
			'filterEpisodesPopup.sortAscending' => 'Sortera stigande',
			'filterEpisodesPopup.sortDescending' => 'Sortera fallande',
			'mediaEvents.rewind' => 'Spola tillbaka',
			'mediaEvents.fastForward' => 'Spola framåt',
			'mediaPlayer.play' => 'Spela',
			'mediaPlayer.pause' => 'Pausa',
			'mediaPlayer.rewind10' => 'Spola tillbaka 10 sekunder',
			'mediaPlayer.rewind5' => 'Spola tillbaka 5 sekunder',
			'mediaPlayer.rewind30' => 'Spola tillbaka 30 sekunder',
			'mediaPlayer.forward10' => 'Hoppa framåt 10 sekunder',
			'mediaPlayer.forward5' => 'Hoppa framåt 5 sekunder',
			'mediaPlayer.forward30' => 'Hoppa framåt 30 sekunder',
			'podcastDetails.podcastImage' => 'Poddbild',
			'podcastDetails.rssFeed' => 'Rss-flöde',
			'podcastDetails.expandDescription' => 'Visa mer',
			'podcastDetails.showLess' => 'Visa mindre',
			'podcastDetails.showMore' => 'Visa mer',
			'podcastDetails.loading' => 'Laddar...',
			'podcastDetails.areYouSureToUnsubscribe' => 'Är du säker på att du vill avprenumerera?',
			'podcastDetails.yes' => 'Ja',
			'podcastDetails.no' => 'Nej',
			'podcastDetails.unsubscribe' => 'Avprenumerera',
			'podcastDetails.addPodcast' => 'Lägg till podd',
			'settings.title' => 'Inställningar',
			'smallMediaPlayer.errorLoadingEpisode' => 'Fel vid laddning av avsnitt',
			'smallMediaPlayer.nothingIsPlaying' => 'Inget spelas just nu',
			'exitDialog.title' => 'Är du säker på att du vill avsluta?',
			'exitDialog.yes' => 'Ja',
			'exitDialog.no' => 'Nej',
			'queue.addToQueue' => 'Lägg till i kö',
			'queue.removeFromQueue' => 'Ta bort från kö',
			_ => null,
		};
	}
}
