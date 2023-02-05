import 'package:meta/meta.dart';

import 'log_level.dart';

/// Message for logging
@immutable
class LogMessage {
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

  /// Stack trace
  StackTrace? get stackTrace => null;

  /// Message for logging to Map<String, Object?>
  Map<String, Object?> toJson() => <String, Object>{
        'date': date.millisecondsSinceEpoch ~/ 1000,
        'message': message.toString(),
        'level': level.prefix,
      };

  @override
  String toString() => message.toString();
}
