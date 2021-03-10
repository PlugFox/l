import 'package:meta/meta.dart';

import 'log_level.dart';

/// Message for logging
@immutable
class LogMessage {
  /// Log date
  final DateTime date;

  /// Message data
  final Object message;

  /// Verbose level
  final LogLevel level;

  /// Message for logging
  const LogMessage({
    required this.message,
    required this.date,
    LogLevel? level,
  }) : level = level ?? const LogLevel.vvvvvv();

  /// Message for logging to Map<String, dynamic>
  Map<String, dynamic> toJson() => <String, dynamic>{
        'date': date.millisecondsSinceEpoch ~/ 1000,
        'message': message.toString(),
        'level': level.prefix,
      };

  @override
  String toString() => message.toString();
}
