import 'package:podcast_core/services/logging/log_sink.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'log_sink_provider.g.dart';

/// The [LogSink] shared business logic reports through.
///
/// Defaults to [NoopLogSink] so the core package and the OSS app build and
/// behave with no backend logging. Host apps override this provider with their
/// own adapter that fans events out to whatever telemetry or logging backend
/// they provide.
///
/// ```dart
/// ProviderScope(
///   overrides: [
///     logSinkProvider.overrideWithValue(myLogSink),
///   ],
///   ...
/// )
/// ```
@Riverpod(keepAlive: true)
LogSink logSink(Ref ref) => const NoopLogSink();
