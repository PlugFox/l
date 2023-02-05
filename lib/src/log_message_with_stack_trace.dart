import 'package:meta/meta.dart';

import 'log_level.dart';
import 'log_message.dart';

/// Message (error, exception, warning) for logging with stack trace
@immutable
class LogMessageWithStackTrace extends LogMessage {
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
  @override
  final StackTrace stackTrace;

  /// Message for logging to Map<String, Object?>
  @override
  Map<String, Object?> toJson() => <String, Object?>{
        ...super.toJson(),
        'stack_trace': stackTrace.toString(),
      };
}
