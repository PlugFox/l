import 'package:meta/meta.dart';

import 'log_level.dart';
import 'logger.dart';

/// {@template log_message}
/// Message for logging
/// {@endtemplate}
@immutable
sealed class LogMessage implements Comparable<LogMessage> {
  /// {@macro log_message}
  LogMessage({
    required this.message,
    required this.level,
    required this.timestamp,
    LogMessageContext? context,
  }) : context = context != null
            ? Map<String, Object?>.unmodifiable(context)
            : const <String, Object?>{};

  /// Normal message
  ///
  /// {@macro log_message}
  factory LogMessage.verbose({
    required Object message,
    required LogLevel level,
    required DateTime timestamp,
    LogMessageContext? context,
  }) = LogMessageVerbose;

  /// Error message
  ///
  /// {@macro log_message}
  factory LogMessage.error({
    required Object message,
    required LogLevel level,
    required DateTime timestamp,
    StackTrace? stackTrace,
    LogMessageContext? context,
  }) = LogMessageError;

  /// Create new loggin message
  ///
  /// {@macro log_message}
  factory LogMessage.create(
    Object message,
    LogLevel level, {
    StackTrace? stackTrace,
    LogMessageContext? context,
  }) =>
      stackTrace == null
          ? LogMessageVerbose(
              message: message,
              level: level,
              timestamp: DateTime.now(),
              context: context,
            )
          : LogMessageError(
              message: message,
              level: level,
              timestamp: DateTime.now(),
              stackTrace: stackTrace,
              context: context,
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
    return stackTrace == null && json['type'] != 'error'
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

  /// Log context
  @nonVirtual
  final LogMessageContext context;

  /// Make a copy of the message
  LogMessage copyWith({
    Object? message,
    LogLevel? level,
    DateTime? timestamp,
    StackTrace? stackTrace,
  }) =>
      switch (this) {
        LogMessageVerbose msg when stackTrace != null => LogMessageError(
            message: message ?? msg.message,
            level: level ?? msg.level,
            timestamp: timestamp ?? msg.timestamp,
            stackTrace: stackTrace,
          ),
        LogMessageVerbose msg => LogMessageVerbose(
            message: message ?? msg.message,
            level: level ?? msg.level,
            timestamp: timestamp ?? msg.timestamp,
          ),
        LogMessageError msg => LogMessageError(
            message: message ?? msg.message,
            level: level ?? msg.level,
            timestamp: timestamp ?? msg.timestamp,
            stackTrace: stackTrace ?? msg.stackTrace,
          ),
      };

  /// Make a copy of the message
  LogMessage copy() => copyWith();

  /// Message for logging to Map<String, Object?>
  ///
  /// [message] is converted to [String] `message`
  /// [level] is converted to [String] `level` prefix (e.g. `e`)
  /// [timestamp] is converted to [int] `date` microseconds since epoch
  /// [stackTrace] is converted to [String] `stacktrace`
  /// [context] is converted to [Map<String, Object?>] `context`
  ///
  /// If context flag is false (by default) then [context]
  /// is not included in the output.
  Map<String, Object?> toJson({bool context = false});

  /// Compare [LogMessage]s by [timestamp]
  @override
  int compareTo(LogMessage other) => timestamp.compareTo(other.timestamp);

  @override
  String toString() => message.toString();
}

/// Verbose message for logging (without stack trace)
///
/// {@macro log_message}
final class LogMessageVerbose extends LogMessage {
  /// {@macro log_message}
  LogMessageVerbose({
    required super.message,
    required super.level,
    required super.timestamp,
    super.context,
  });

  @override
  Map<String, Object?> toJson({bool context = false}) => <String, Object>{
        'type': 'verbose',
        'message': message.toString(),
        'level': level.prefix,
        'timestamp': timestamp.microsecondsSinceEpoch,
        if (context) 'context': this.context,
      };
}

/// Message (error, exception, warning) for logging with stack trace
///
/// {@macro log_message}
final class LogMessageError extends LogMessage {
  /// {@macro log_message}
  LogMessageError({
    required super.message,
    required super.level,
    required super.timestamp,
    StackTrace? stackTrace,
    super.context,
  }) : stackTrace = stackTrace ?? StackTrace.empty;

  /// Stack trace
  final StackTrace stackTrace;

  @override
  Map<String, Object?> toJson({bool context = false}) => <String, Object>{
        'type': 'error',
        'message': message.toString(),
        'level': level.prefix,
        'timestamp': timestamp.microsecondsSinceEpoch,
        'stacktrace': stackTrace.toString(),
        if (context) 'context': this.context,
      };
}
