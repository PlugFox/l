import 'package:meta/meta.dart';

import 'log_level.dart';
import 'log_level_map.dart' show levelsAllocation;

/// Message for logging
@immutable
class LogMessage {
  /// Log date
  final DateTime date;

  /// Message data
  final Object message;

  /// Verbose level
  final LogLevel level;

  /// Display in console?
  final bool print;

  /// Store in txt/indexedDB?
  final bool store;

  /// Prefix from log level
  String get prefix => _prefixFromLogLevel();

  /// Message for logging
  const LogMessage(
      {this.date,
      @required this.message,
      LogLevel level,
      bool displayInConsole,
      bool store})
      : assert(date is DateTime && message != null),
        level = level ?? LogLevel.vvvvvv,
        print = displayInConsole ?? true,
        store = store ?? true;

  String _prefixFromLogLevel() {
    switch (level) {
      case (LogLevel.shout):
        return '!!!!!!';
      case (LogLevel.v):
        return '     *';
      case (LogLevel.vv):
        return '    **';
      case (LogLevel.vvv):
        return '   ***';
      case (LogLevel.vvvv):
        return '  ****';
      case (LogLevel.vvvvv):
        return ' *****';
      case (LogLevel.vvvvvv):
        return '******';
      case (LogLevel.info):
        return '     i';
      case (LogLevel.warning):
        return '     w';
      case (LogLevel.error):
        return '     e';
      case (LogLevel.debug):
        return '     d';
      default:
        return '      ';
    }
  }

  @override
  String toString() => '[$prefix] $message';

  /// Message for logging to Map<String, dynamic>
  Map<String, dynamic> toMap() => <String, dynamic>{
        'date': date.millisecondsSinceEpoch,
        'message': message?.toString(),
        'level': levelsAllocation[level],
      };
}
