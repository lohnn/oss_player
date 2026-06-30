import 'package:podcast_core/services/logging/log_sink.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'log_sink_provider.g.dart';

/// The [LogSink] shared business logic reports through.
///
/// Defaults to [NoopLogSink] so the core package and the OSS app build and
/// behave with no backend logging. The production app overrides this provider
/// with an adapter that fans events out to the Loki buffer + Crashlytics.
///
/// ```dart
/// ProviderScope(
///   overrides: [
///     logSinkProvider.overrideWithValue(myLokiCrashlyticsSink),
///   ],
///   ...
/// )
/// ```
@Riverpod(keepAlive: true)
LogSink logSink(Ref ref) => const NoopLogSink();
