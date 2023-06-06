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
  LogMessage.create(this.message, this.level) : date = DateTime.now();

  /// Message for logging with [StackTrace]
  factory LogMessage.stackTrace({
    required Object message,
    required LogLevel level,
    required StackTrace stackTrace,
    DateTime? date,
  }) =>
      LogMessageWithStackTrace(
        message: message,
        level: level,
        date: date ?? DateTime.now(),
        stackTrace: stackTrace,
      );

  /// Restore [LogMessage] from Map<String, Object?>
  factory LogMessage.fromJson(Map<String, Object?> json) {
    final <String, Object?>{
      'date': jsonDate,
      'message': jsonMessage,
      'level': jsonLevel,
    } = json;
    final jsonStackTrace = json['stack_trace'];
    final date = jsonDate is int
        ? DateTime.fromMicrosecondsSinceEpoch(jsonDate)
        : DateTime.now();
    return jsonStackTrace == null
        ? LogMessage(
            message: jsonMessage.toString(),
            level: LogLevel.fromValue(jsonLevel),
            date: date,
          )
        : LogMessageWithStackTrace(
            message: jsonMessage.toString(),
            level: LogLevel.fromValue(jsonLevel),
            date: date,
            stackTrace: StackTrace.fromString(jsonStackTrace.toString()),
          );
  }

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
  /// [date] is converted to [int] `date` microseconds since epoch
  /// [message] is converted to [String] `message`
  /// [level] is converted to [String] `level` prefix (e.g. `e`)
  /// [stackTrace] is converted to [String] `stack_trace`
  Map<String, Object?> toJson() => <String, Object>{
        'date': date.microsecondsSinceEpoch,
        'message': message.toString(),
        'level': level.prefix,
        if (this case LogMessageWithStackTrace(:final StackTrace stackTrace))
          'stack_trace': stackTrace.toString(),
      };

  @override
  String toString() => message.toString();
}

/// Message (error, exception, warning) for logging with stack trace
final class LogMessageWithStackTrace extends LogMessage {
  /// Message for logging
  const LogMessageWithStackTrace({
    required super.message,
    required super.level,
    required super.date,
    required this.stackTrace,
  });

  /// Message for logging
  LogMessageWithStackTrace.create(
    super.message,
    super.level,
    this.stackTrace,
  ) : super.create();

  /// Stack trace
  /// This field cannot be transferred between isolates
  final StackTrace stackTrace;
}
