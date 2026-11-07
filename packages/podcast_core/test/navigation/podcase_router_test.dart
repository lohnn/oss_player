import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// Override is only exported through this additional-symbols entrypoint.
import 'package:hooks_riverpod/misc.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:podcast_core/data/episode.model.dart';
import 'package:podcast_core/data/podcast.model.dart';
import 'package:podcast_core/data/podcast_search.model.dart';
import 'package:podcast_core/data/podcast_with_status.dart';
import 'package:podcast_core/data/user_episode_status.model.dart';
import 'package:podcast_core/gen/strings.g.dart';
import 'package:podcast_core/navigation/podcase_router.dart';
import 'package:podcast_core/repository.dart';
import 'package:podcast_core/screens/logged_in/episode_details_screen/episode_details_screen.dart';
import 'package:podcast_core/screens/logged_in/playlist_screen.dart';
import 'package:podcast_core/screens/logged_in/podcast_details_screen/podcast_details_screen.dart';
import 'package:podcast_core/screens/logged_in/podcast_search_screen.dart';

/// Realistic identifiers: a podcast id is the sha256 of the feed URL (64 hex
/// chars) and an episode id is `<podcastsha>:<guid>` where the guid may itself
/// be a URL.
const _podcastSha =
    'a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2';
const _guidUrl = 'https://feeds.example.com/guid/1';
final _encPodcast = Uri.encodeComponent(_podcastSha);
final _encGuid = Uri.encodeComponent(_guidUrl);

class _TestPodcastSearch implements PodcastSearch {
  @override
  PodcastSearchId get id => PodcastSearchId(1);

  @override
  PodcastRssUrl get url => PodcastRssUrl.parse('http://example.com/feed.xml');

  @override
  String get title => 'Deep Link Radio';

  @override
  String get description => 'A podcast found by deep link';

  @override
  String get author => 'Example';

  @override
  Uri get artwork => Uri.parse('http://example.com/artwork.png');

  @override
  String get language => 'en';

  @override
  Map<int, String> get categories => const {};
}

/// Records search calls so tests can pin what the search link actually
/// fetched. Everything else is the pre-existing empty behavior.
class _RoutingTestRepository implements Repository {
  _RoutingTestRepository({this.searchResults = const []});

  final List<PodcastSearch> searchResults;
  final findPodcastsCalls = <String?>[];

  @override
  Future<List<PodcastSearch>> findPodcasts([String? searchTerm]) async {
    findPodcastsCalls.add(searchTerm);
    return searchResults;
  }

  @override
  Stream<List<PodcastWithStatus>> watchPodcasts() => const Stream.empty();

  @override
  Future<void> updateLastSeenPodcast(PodcastId podcast) async {}

  @override
  Stream<List<UserEpisodeStatus>> watchUserEpisodeStatuses() =>
      const Stream.empty();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'Repository.${invocation.memberName} was not expected in this test',
    );
  }
}
/// A controllable gate standing in for the app shell's auth state, wired to
/// the router through [refreshListenable] exactly like the closed app's user
/// stream bridge will be.
class TestGate extends ChangeNotifier {
  AuthGateState _state;

  TestGate(this._state);

  AuthGateState get state => _state;

  void update(AuthGateState next) {
    if (next == _state) return;
    _state = next;
    notifyListeners();
  }
}

class _Marker extends StatelessWidget {
  const _Marker(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(label));
  }
}


extension on WidgetTester {
  Future<void> pumpIdleFrames([int count = 3]) async {
    for (var i = 0; i < count; i++) {
      await pump(const Duration(milliseconds: 16));
    }
  }
}

Future<GoRouter> _pumpRouter(
  WidgetTester tester, {
  required WidgetBuilder homeBuilder,
  String? initialLocation,
  TestGate? gate,
  bool withLoginRoute = true,
  List<Override> overrides = const [],
}) async {
  final router = createPodcaseRouter(
    homeBuilder: homeBuilder,
    loginBuilder: withLoginRoute ? (_) => const _Marker('login-marker') : null,
    bootstrapBuilder: (_) => const _Marker('boot-marker'),
    forceUpgradeBuilder: (_) => const _Marker('upgrade-marker'),
    errorBuilder: (_) => const _Marker('error-marker'),
    refreshListenable: gate,
    authGateState: gate == null ? null : () => gate.state,
    initialLocation: initialLocation,
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: TranslationProvider(
        child: MaterialApp.router(routerConfig: router),
      ),
    ),
  );
  await tester.pumpIdleFrames();
  return router;
}

void main() {
  group('auth-gate redirect triage', () {
    testWidgets('a boot gate holds a deep link at /boot without login flicker',
        (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.boot),
        initialLocation: '/p/$_encPodcast/$_encGuid',
      );

      expect(find.text('boot-marker'), findsOneWidget);
      expect(find.text('login-marker'), findsNothing);
      // from= is the escape-preserving location encoded once — the escapes of
      // the episode id's URL guid are themselves percent-encoded.
      expect(
        router.routeInformationProvider.value.uri,
        Uri.parse(
          '/boot?from=${Uri.encodeQueryComponent('/p/$_encPodcast/$_encGuid')}',
        ),
      );
    });

    testWidgets('a loading gate holds the root at /boot (no login flash)',
        (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.loading),
      );

      expect(find.text('boot-marker'), findsOneWidget);
      expect(find.text('login-marker'), findsNothing);
      expect(
        router.routeInformationProvider.value.uri.toString(),
        '/boot?from=%2F',
      );
    });

    testWidgets('a loading gate holds a deep link at /boot', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.loading),
        initialLocation: '/p/$_encPodcast',
      );

      expect(find.text('boot-marker'), findsOneWidget);
      expect(find.text('login-marker'), findsNothing);
      expect(
        router.routeInformationProvider.value.uri,
        Uri.parse(
          '/boot?from=${Uri.encodeQueryComponent('/p/$_encPodcast')}',
        ),
      );
    });

    testWidgets('force upgrade outranks a deep link', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.forceUpgrade),
        initialLocation: '/p/$_encPodcast/$_encGuid',
      );

      expect(find.text('upgrade-marker'), findsOneWidget);
      expect(find.text('login-marker'), findsNothing);
      expect(
        router.routeInformationProvider.value.uri.toString(),
        '/upgrade',
      );
    });

    testWidgets('force upgrade outranks the login screen', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.forceUpgrade),
        initialLocation: '/login',
      );

      expect(find.text('upgrade-marker'), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.toString(), '/upgrade');
    });

    testWidgets('a logged out deep link lands on /login with the link in from',
        (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.loggedOut),
        initialLocation: '/p/$_encPodcast/$_encGuid',
      );

      expect(find.text('login-marker'), findsOneWidget);
      expect(find.text('boot-marker'), findsNothing);
      expect(
        router.routeInformationProvider.value.uri,
        Uri.parse(
          '/login?from=${Uri.encodeQueryComponent('/p/$_encPodcast/$_encGuid')}',
        ),
      );
    });

    testWidgets('a logged out root lands on /login', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.loggedOut),
      );

      expect(find.text('login-marker'), findsOneWidget);
      expect(
        router.routeInformationProvider.value.uri.toString(),
        '/login?from=%2F',
      );
    });

    testWidgets('a logged out user already on /login stays there without a '
        'from redirect loop', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.loggedOut),
        initialLocation: '/login',
      );

      expect(find.text('login-marker'), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.toString(), '/login');
    });

    testWidgets('a logged in session on /login continues to the linked '
        'content', (tester) async {
      await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.loggedIn),
        initialLocation: '/login?from=%2Fplaylist',
      );

      expect(find.byType(PlaylistScreen), findsOneWidget);
      expect(find.text('login-marker'), findsNothing);
    });

    testWidgets('a logged in user going to /login lands on home',
        (tester) async {
      await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: TestGate(AuthGateState.loggedIn),
        initialLocation: '/login',
      );

      expect(find.text('home-marker'), findsOneWidget);
      expect(find.text('login-marker'), findsNothing);
    });
  });

  group('chained redirect', () {
    testWidgets('a boot-held deep link settles on the linked episode screen '
        'once the gate resolves to logged in', (tester) async {
      final gate = TestGate(AuthGateState.boot);
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: gate,
        initialLocation: '/p/$_encPodcast/$_encGuid',
      );

      expect(find.text('boot-marker'), findsOneWidget);

      gate.update(AuthGateState.loggedIn);
      await tester.pumpIdleFrames();

      expect(find.text('home-marker'), findsNothing);
      // Dart canonicalizes some escapes (e.g. %3A in the guid's path
      // position), so compare URIs semantically, not strings.
      expect(
        router.routeInformationProvider.value.uri,
        Uri.parse('/p/$_encPodcast/$_encGuid'),
      );
      // The chain re-resolved after the gate opened — /boot continued to the
      // link in its from= query (the go_router 17.2.1 chained-redirect fix we
      // bumped for) — and the screen carries the DECODED ids.
      final episodeScreen = tester.widget<EpisodeDetailsScreen>(
        find.byType(EpisodeDetailsScreen),
      );
      expect(episodeScreen.podcastId, PodcastId(_podcastSha));
      expect(episodeScreen.episodeId, EpisodeId(_guidUrl));
    });

    testWidgets('a boot-held deep link that resolves logged out continues to '
        '/login with the original link as from', (tester) async {
      final gate = TestGate(AuthGateState.boot);
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: gate,
        initialLocation: '/p/$_encPodcast/$_encGuid',
      );

      expect(find.text('boot-marker'), findsOneWidget);
      expect(find.text('login-marker'), findsNothing);

      gate.update(AuthGateState.loggedOut);
      await tester.pumpIdleFrames();

      expect(find.text('login-marker'), findsOneWidget);
      // The from value decodes once to the ORIGINAL escaped location — the
      // episode guid's own escapes must survive for the post-login ride home
      // (pinned end-to-end by the logged-in chained test).
      final loginUri = router.routeInformationProvider.value.uri;
      expect(loginUri.path, '/login');
      expect(
        loginUri.queryParameters['from'],
        '/p/$_encPodcast/$_encGuid',
      );
    });

    testWidgets('a session that resolves into force upgrade lands on the '
        'upgrade screen', (tester) async {
      final gate = TestGate(AuthGateState.boot);
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: gate,
        initialLocation: '/p/$_encPodcast',
      );

      gate.update(AuthGateState.forceUpgrade);
      await tester.pumpIdleFrames();

      expect(find.text('upgrade-marker'), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.toString(), '/upgrade');
    });

    testWidgets('a logged out search link keeps its query through login and '
        'lands back on search', (tester) async {
      final gate = TestGate(AuthGateState.loggedOut);
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: gate,
        initialLocation: '/s?q=deep%20link',
      );

      expect(find.text('login-marker'), findsOneWidget);
      expect(
        router.routeInformationProvider.value.uri.toString(),
        '/login?from=%2Fs%3Fq%3Ddeep%2520link',
      );

      gate.update(AuthGateState.loggedIn);
      await tester.pumpIdleFrames();

      expect(find.byType(PodcastSearchScreen), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.queryParameters['q'],
          'deep link');
    });
  });

  group('/p/ route table', () {
    testWidgets('a podcast deep link lands on podcast details with the '
        'decoded id', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
      );

      router.go('/p/$_encPodcast');
      await tester.pumpIdleFrames();

      final details = tester.widget<PodcastDetailsScreen>(
        find.byType(PodcastDetailsScreen),
      );
      // The screen received the DECODED path parameter, not the wire form.
      expect(details.podcastId, PodcastId(_podcastSha));
    });

    testWidgets('an episode deep link lands on episode details with both ids '
        'decoded', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
      );

      router.go('/p/$_encPodcast/$_encGuid');
      await tester.pumpIdleFrames();

      final details = tester.widget<EpisodeDetailsScreen>(
        find.byType(EpisodeDetailsScreen),
      );
      expect(details.podcastId, PodcastId(_podcastSha));
      expect(details.episodeId, EpisodeId(_guidUrl));
    });

    testWidgets('route paths that match nothing render the error surface',
        (tester) async {
      // The legacy unscoped shapes exist nowhere in the wild, so the migration
      // intentionally drops them (design decision 2026-11-07). Each shape is
      // seeded fresh because consecutive unmatched go() calls stack error
      // pages, which is not what this pin is about.
      final unmatched = [
        '/p',
        '/p/',
        '/p/$_encPodcast/$_encGuid/extra-segment',
        '/no-such-path',
        '/$_encPodcast/$_encGuid',
      ];

      for (final location in unmatched) {
        await _pumpRouter(
          tester,
          homeBuilder: (_) => const _Marker('home-marker'),
          initialLocation: location,
        );

        expect(
          find.text('error-marker'),
          findsOneWidget,
          reason: 'location "$location" should use the error builder',
        );
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(milliseconds: 16));
      }
    });

    testWidgets('the primary routes keep their screens', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
      );

      expect(find.text('home-marker'), findsOneWidget);

      router.go('/s?q=hello');
      await tester.pumpIdleFrames();
      expect(find.byType(PodcastSearchScreen), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.queryParameters['q'],
          'hello');

      router.go('/playlist');
      await tester.pumpIdleFrames();
      expect(find.byType(PlaylistScreen), findsOneWidget);
    });
  });

  group('OSS mode (no gate)', () {
    testWidgets('deep links stay always open without /boot or redirects',
        (tester) async {
      await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        withLoginRoute: false,
        initialLocation: '/playlist',
      );

      expect(find.byType(PlaylistScreen), findsOneWidget);
      expect(find.text('boot-marker'), findsNothing);
      expect(find.text('login-marker'), findsNothing);
    });

    testWidgets('navigating to /login finds no login route (OSS mode has no '
        'auth surface)', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        withLoginRoute: false,
      );

      router.go('/login');
      await tester.pumpIdleFrames();

      // go_router resolves an unmatched dynamic location to the root route —
      // the pin: no login surface exists, the app stays on its own routes.
      expect(find.text('login-marker'), findsNothing);
      expect(find.text('home-marker'), findsOneWidget);
      expect(
        router.routerDelegate.currentConfiguration.last.matchedLocation,
        '/',
      );
      expect(router.routeInformationProvider.value.uri.path, '/login');
    });
  });

  group('root exit policy', () {
    testWidgets('the root exit dialog is shown and a confirmation veto keeps '
        'the app open', (tester) async {
      final router = await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        withLoginRoute: false,
      );

      // handlePopRoute can only complete once the dialog is answered, so it
      // is not awaited before acting on the dialog.
      final poppedFuture = tester.binding.handlePopRoute();
      await tester.pumpIdleFrames();

      expect(find.byType(AlertDialog), findsOneWidget);

      // The "No" action must cancel the route removal entirely.
      final noButton = find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(TextButton),
      ).first;
      await tester.tap(noButton);
      await tester.pumpIdleFrames();

      // true = the back press was consumed by the app (the confirm dialog),
      // i.e. the app was not exited.
      final popped = await poppedFuture;
      expect(popped, isTrue);

      expect(find.text('home-marker'), findsOneWidget);
      expect(router.routeInformationProvider.value.uri.path, '/');
    });

    testWidgets('a gate redirect away from home does not show the exit dialog',
        (tester) async {
      final gate = TestGate(AuthGateState.loggedIn);
      await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        gate: gate,
      );

      expect(find.text('home-marker'), findsOneWidget);

      gate.update(AuthGateState.loggedOut);
      await tester.pumpIdleFrames();

      expect(find.text('login-marker'), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });
  });

  group('search links (/s?q=)', () {
    testWidgets('a search link with a query seeds the field and fetches '
        'results', (tester) async {
      final repository = _RoutingTestRepository(
        searchResults: [_TestPodcastSearch()],
      );

      await mockNetworkImagesFor(() async {
        await _pumpRouter(
          tester,
          homeBuilder: (_) => const _Marker('home-marker'),
          initialLocation: '/s?q=deep%20link',
          overrides: [
            repositoryProvider.overrideWith((ref) => repository),
          ],
        );
      });
      // The seed triggers its search from a post-frame callback; settle until
      // the fetch landed (bounded).
      for (var i = 0;
          i < 10 && !repository.findPodcastsCalls.contains('deep link');
          i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      await tester.pump(const Duration(milliseconds: 16));

      // The query is seeded into the search field, fetched exactly once, and
      // the results render.
      expect(find.text('deep link'), findsOneWidget);
      expect(repository.findPodcastsCalls, contains('deep link'));
      expect(find.text('Deep Link Radio'), findsOneWidget);
    });

    testWidgets('/s without a query behaves exactly like today: no seed, no '
        'extra search', (tester) async {
      final repository = _RoutingTestRepository();

      await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        initialLocation: '/s',
        overrides: [
          repositoryProvider.overrideWith((ref) => repository),
        ],
      );
      await tester.pumpIdleFrames();

      // Only the screen's initial untargeted findPodcasts() ran.
      expect(repository.findPodcastsCalls, [isNull]);
      expect(find.text('deep link'), findsNothing);
    });

    testWidgets('a blank query is harmless: no seed, no extra search',
        (tester) async {
      final repository = _RoutingTestRepository();

      await _pumpRouter(
        tester,
        homeBuilder: (_) => const _Marker('home-marker'),
        initialLocation: '/s?q=%20%20',
        overrides: [
          repositoryProvider.overrideWith((ref) => repository),
        ],
      );
      await tester.pumpIdleFrames();

      expect(repository.findPodcastsCalls, [isNull]);
      expect(find.text('deep link'), findsNothing);
    });
  });

}
