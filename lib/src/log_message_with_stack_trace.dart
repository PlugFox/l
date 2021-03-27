import 'package:meta/meta.dart';

import 'log_level.dart';
import 'log_message.dart';

/// Message for logging with error or warning stack trace
@immutable
class LogMessageWithStackTrace extends LogMessage {
  /// Stack trace
  final StackTrace stackTrace;

  /// Message for logging
  const LogMessageWithStackTrace({
    required Object message,
    required DateTime date,
    required this.stackTrace,
    LogLevel? level,
  }) : super(
          message: message,
          date: date,
          level: level,
        );
}
