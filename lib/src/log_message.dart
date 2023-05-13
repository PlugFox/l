import 'package:meta/meta.dart';

import 'log_level.dart';

/// Message for logging
@immutable
final class LogMessage {
  /// Message for logging
  const LogMessage({
    required this.message,
    required this.level,
    required this.date,
  });

  /// Create new loggin message
  factory LogMessage.create(Object message, LogLevel level) => LogMessage(
        message: message,
        level: level,
        date: DateTime.now(),
      );

  /// Log date
  @nonVirtual
  final DateTime date;

  /// Message data
  @nonVirtual
  final Object message;

  /// Verbose level
  @nonVirtual
  final LogLevel level;

  /// Message for logging to Map<String, Object?>
  Map<String, Object?> toJson() => <String, Object>{
        'date': date.millisecondsSinceEpoch ~/ 1000,
        'message': message.toString(),
        'level': level.prefix,
      };

  @override
  String toString() => message.toString();
}

/// Message (error, exception, warning) for logging with stack trace
@immutable
final class LogMessageWithStackTrace extends LogMessage {
  /// Message for logging
  LogMessageWithStackTrace.create(
    Object message,
    LogLevel level,
    this.stackTrace,
  ) : super(
          message: message,
          level: level,
          date: DateTime.now(),
        );

  /// Stack trace
  /// This field cannot be transferred between isolates
  @experimental
  final StackTrace stackTrace;

  /// Message for logging to Map<String, Object?>
  @override
  Map<String, Object?> toJson() => <String, Object?>{
        ...super.toJson(),
        'stack_trace': stackTrace.toString(),
      };
}
