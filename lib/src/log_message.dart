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

  /// Display wide prefix entry
  final bool _wide;

  /// Prefix from log level
  String get prefix => _prefixFromLogLevel();

  /// Message for logging
  const LogMessage(
      {this.date,
      @required this.message,
      LogLevel level,
      bool displayInConsole,
      bool store,
      bool wide})
      : assert(date is DateTime && message != null),
        level = level ?? LogLevel.vvvvvv,
        print = displayInConsole ?? true,
        store = store ?? true,
        _wide = wide ?? false;

  String _prefixFromLogLevel() {
    switch (level) {
      case (LogLevel.shout):
        return _wide ? '!!!!!!' : '!';
      case (LogLevel.v):
        return _wide ? '     *' : '1';
      case (LogLevel.vv):
        return _wide ? '    **' : '2';
      case (LogLevel.vvv):
        return _wide ? '   ***' : '3';
      case (LogLevel.vvvv):
        return _wide ? '  ****' : '4';
      case (LogLevel.vvvvv):
        return _wide ? ' *****' : '5';
      case (LogLevel.vvvvvv):
        return _wide ? '******' : '6';
      case (LogLevel.info):
        return _wide ? '     i' : 'i';
      case (LogLevel.warning):
        return _wide ? '     W' : 'W';
      case (LogLevel.error):
        return _wide ? '     E' : 'E';
      case (LogLevel.debug):
        return _wide ? '     d' : 'd';
      default:
        return _wide ? '      ' : ' ';
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
