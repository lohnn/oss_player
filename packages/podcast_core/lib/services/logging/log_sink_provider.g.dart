// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_sink_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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

@ProviderFor(logSink)
const logSinkProvider = LogSinkProvider._();

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

final class LogSinkProvider
    extends $FunctionalProvider<LogSink, LogSink, LogSink>
    with $Provider<LogSink> {
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
  const LogSinkProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logSinkProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logSinkHash();

  @$internal
  @override
  $ProviderElement<LogSink> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LogSink create(Ref ref) {
    return logSink(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LogSink value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LogSink>(value),
    );
  }
}

String _$logSinkHash() => r'16fde7d72786fc17a3b716615a708662e25c1506';
