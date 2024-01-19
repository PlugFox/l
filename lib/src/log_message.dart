import 'package:meta/meta.dart';

import 'log_level.dart';

/// {@template log_message}
/// Message for logging
/// {@endtemplate}
@immutable
sealed class LogMessage {
  /// {@macro log_message}
  const LogMessage({
    required this.message,
    required this.level,
    required this.timestamp,
  });

  /// Normal message
  ///
  /// {@macro log_message}
  const factory LogMessage.verbose({
    required Object message,
    required LogLevel level,
    required DateTime timestamp,
  }) = LogMessageVerbose;

  /// Error message
  ///
  /// {@macro log_message}
  const factory LogMessage.error({
    required Object message,
    required LogLevel level,
    required DateTime timestamp,
    required StackTrace? stackTrace,
  }) = LogMessageError;

  /// Create new loggin message
  ///
  /// {@macro log_message}
  factory LogMessage.create(
    Object message,
    LogLevel level, {
    StackTrace? stackTrace,
  }) =>
      stackTrace == null
          ? LogMessageVerbose(
              message: message,
              level: level,
              timestamp: DateTime.now(),
            )
          : LogMessageError(
              message: message,
              level: level,
              timestamp: DateTime.now(),
              stackTrace: stackTrace,
            );

  /// Restore [LogMessage] from Map<String, Object?>
  ///
  /// {@macro log_message}
  factory LogMessage.fromJson(Map<String, Object?> json) {
    final message = json['message'] ?? '';
    final level = LogLevel.fromValue(json['level']);
    final timestamp = switch (json['timestamp']) {
          DateTime dt => dt,
          int n => DateTime.fromMicrosecondsSinceEpoch(n),
          String s => DateTime.tryParse(s),
          _ => null,
        } ??
        DateTime.now();
    final stackTrace = switch (json['stacktrace']) {
      String s => StackTrace.fromString(s),
      StackTrace st => st,
      _ => null,
    };
    return stackTrace == null
        ? LogMessageVerbose(
            message: message,
            level: level,
            timestamp: timestamp,
          )
        : LogMessageError(
            message: message,
            level: level,
            timestamp: timestamp,
            stackTrace: stackTrace,
          );
  }

  /// Message data
  @nonVirtual
  final Object message;

  /// Verbose level
  @nonVirtual
  final LogLevel level;

  /// Log date
  @nonVirtual
  final DateTime timestamp;

  /// Message for logging to Map<String, Object?>
  ///
  /// [message] is converted to [String] `message`
  /// [level] is converted to [String] `level` prefix (e.g. `e`)
  /// [timestamp] is converted to [int] `date` microseconds since epoch
  /// [stackTrace] is converted to [String] `stacktrace`
  Map<String, Object?> toJson();

  @override
  String toString() => message.toString();
}

/// Verbose message for logging (without stack trace)
///
/// {@macro log_message}
final class LogMessageVerbose extends LogMessage {
  /// {@macro log_message}
  const LogMessageVerbose({
    required super.message,
    required super.level,
    required super.timestamp,
  });

  @override
  Map<String, Object?> toJson() => <String, Object>{
        'message': message.toString(),
        'level': level.prefix,
        'timestamp': timestamp.microsecondsSinceEpoch,
      };
}

/// Message (error, exception, warning) for logging with stack trace
///
/// {@macro log_message}
final class LogMessageError extends LogMessage {
  /// {@macro log_message}
  const LogMessageError({
    required super.message,
    required super.level,
    required super.timestamp,
    required StackTrace? stackTrace,
  }) : stackTrace = stackTrace ?? StackTrace.empty;

  /// Stack trace
  final StackTrace stackTrace;

  @override
  Map<String, Object?> toJson() => <String, Object>{
        'message': message.toString(),
        'level': level.prefix,
        'timestamp': timestamp.microsecondsSinceEpoch,
        'stacktrace': stackTrace.toString(),
      };
}
