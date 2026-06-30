import 'package:flutter/foundation.dart';

/// Severity of a telemetry event reported through a [LogSink].
///
/// Mirrors the well-known levels of `package:logging` so a host app's adapter
/// can map straight onto its telemetry backend, while staying free of any
/// dependency on a concrete logging backend.
enum LogLevel {
  debug,
  info,
  warning,
  error;

  /// Whether this level is at least as severe as [other].
  bool operator >=(LogLevel other) => index >= other.index;
}

/// A single structured telemetry event produced by shared business logic.
///
/// This is a presentation-agnostic value object (I-069): the core defines the
/// *shape* of what it wants to report, and each app provides an adapter that
/// projects it onto whatever telemetry or logging backend the host app
/// provides (debug console / nothing in the OSS app).
///
/// [context] holds structured fields — podcast/episode/screen ids, request
/// ids, etc. — as plain JSON-encodable values, never bare interpolated
/// strings, so the backend can filter on them.
@immutable
class LogEvent {
  const LogEvent({
    required this.level,
    required this.message,
    this.name,
    this.error,
    this.stackTrace,
    this.context = const {},
  });

  /// Severity of the event.
  final LogLevel level;

  /// Human-readable summary of what happened.
  final String message;

  /// Optional logical source (e.g. the feature or provider name) used as a
  /// secondary label/field on the backend.
  final String? name;

  /// The caught error, if this event reports a failure.
  final Object? error;

  /// Stack trace associated with [error], if any.
  final StackTrace? stackTrace;

  /// Structured, filterable fields (podcast/episode/screen/request ids, …).
  ///
  /// Values must be JSON-encodable. Prefer typed keys over interpolating ids
  /// into [message] so the backend stays queryable.
  final Map<String, Object?> context;

  LogEvent copyWith({Map<String, Object?>? context}) => LogEvent(
    level: level,
    message: message,
    name: name,
    error: error,
    stackTrace: stackTrace,
    context: context ?? this.context,
  );
}

/// The seam through which shared business logic in `podcast_core` reports
/// observability events without knowing where they go.
///
/// The OSS app injects [NoopLogSink] (or a debug-printing sink); a host app can
/// inject an adapter that fans the event out to whatever telemetry or logging
/// backend it provides. Core code depends only on this interface, so it stays
/// buildable and unit-testable against a stub sink (I-069).
///
/// Implementations MUST be non-throwing: a failure to report telemetry must
/// never propagate into the business logic that called [log] (don't let the
/// observer crash the observed).
///
/// This is an `abstract class` (not an `abstract interface class`) on purpose:
/// it is both extendable and implementable. Real sinks should `extends LogSink`
/// so they inherit the shared [reportError] convenience; test stubs may still
/// `implements LogSink` when they want to satisfy the contract without the base
/// behaviour.
abstract class LogSink {
  const LogSink();

  /// Report a structured event. Must not throw.
  void log(LogEvent event);

  /// Convenience for reporting a caught error at [LogLevel.error].
  ///
  /// This is shared behaviour: always wrap the error as a [LogLevel.error]
  /// [LogEvent] and then call [log]. It lives once on the base class so sinks
  /// don't each reimplement it — they customise *where* events go via [log],
  /// not by overriding [reportError]. (Under the old `implements` contract Dart
  /// did not inherit method bodies, so every sink was forced to duplicate this;
  /// switching to an extendable base removes that duplication.)
  ///
  /// Lets call sites that previously did `catch → debugPrint → rethrow` switch
  /// to `catch → sink.reportError(...) → rethrow` and actually reach the
  /// backend.
  void reportError(
    Object error,
    StackTrace stackTrace, {
    String? message,
    String? name,
    Map<String, Object?> context = const {},
  }) {
    log(
      LogEvent(
        level: LogLevel.error,
        message: message ?? error.toString(),
        name: name,
        error: error,
        stackTrace: stackTrace,
        context: context,
      ),
    );
  }
}

/// A [LogSink] that does nothing. The safe default for the OSS app and tests.
class NoopLogSink extends LogSink {
  const NoopLogSink() : super();

  @override
  void log(LogEvent event) {}
}

/// A [LogSink] that prints to the debug console only. Useful for the OSS app so
/// a developer running it locally can still see core telemetry, while shipping
/// nothing anywhere in release builds.
class DebugPrintLogSink extends LogSink {
  const DebugPrintLogSink() : super();

  @override
  void log(LogEvent event) {
    if (!kDebugMode) return;
    final name = event.name == null ? '' : '[${event.name}] ';
    debugPrint('${event.level.name.toUpperCase()} $name${event.message}');
    if (event.error != null) {
      debugPrint('  error: ${event.error}');
    }
    if (event.context.isNotEmpty) {
      debugPrint('  context: ${event.context}');
    }
    if (event.stackTrace != null) {
      debugPrintStack(stackTrace: event.stackTrace);
    }
  }
}
