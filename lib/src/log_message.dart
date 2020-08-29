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

  /// Maximum log line length
  final int length;

  /// Prefix from log level
  String get prefix => _prefixFromLogLevel();

  /// Message for logging
  const LogMessage({
    @required this.message,
    @required this.date,
    LogLevel level,
    bool displayInConsole,
    bool store,
    bool wide,
    int length,
  })  : assert(date is DateTime && message != null,
            'date and message must not be null'),
        level = level ?? LogLevel.vvvvvv,
        print = displayInConsole ?? true,
        store = store ?? true,
        _wide = wide ?? false,
        length = length ?? 0;

  String _prefixFromLogLevel() {
    switch (level) {
      case LogLevel.shout:
        return _wide ? '!!!!!!' : '!';
      case LogLevel.v:
        return _wide ? '     *' : '1';
      case LogLevel.vv:
        return _wide ? '    **' : '2';
      case LogLevel.vvv:
        return _wide ? '   ***' : '3';
      case LogLevel.vvvv:
        return _wide ? '  ****' : '4';
      case LogLevel.vvvvv:
        return _wide ? ' *****' : '5';
      case LogLevel.vvvvvv:
        return _wide ? '******' : '6';
      case LogLevel.info:
        return _wide ? '     I' : 'I';
      case LogLevel.warning:
        return _wide ? '     W' : 'W';
      case LogLevel.error:
        return _wide ? '     E' : 'E';
      case LogLevel.debug:
        return _wide ? '     D' : 'D';
      default:
        return _wide ? '      ' : ' ';
    }
  }

  @override
  String toString() {
    final prefixString = '[$prefix] ';
    final prefixStringLength = prefixString.length;
    final messageString = message.toString();
    final messageStringLength = messageString.length;
    final padding = prefixStringLength - 2;
    if ((length < 12) || (prefixStringLength + messageStringLength <= length)) {
      return '$prefixString'
          '${messageString.replaceAll('\n', '\n${' ' * padding}| ')}';
    }
    final builder = StringBuffer(prefixString);
    final lineLength = length - prefixStringLength;
    final lines = (messageStringLength / lineLength).ceil();
    for (var i = 0; i < lines; i++) {
      if (i != 0) {
        builder.writeln();
      }
      final messagePadding = i * lineLength;
      builder.write(
        messageString.substring(
          messagePadding,
          (messagePadding + lineLength).clamp(0, messageStringLength).toInt(),
        ),
      );
    }
    return builder.toString().replaceAll('\n', '\n${' ' * padding}| ');
  }

  /// Message for logging to Map<String, dynamic>
  Map<String, dynamic> toMap() => <String, dynamic>{
        'date': date.millisecondsSinceEpoch,
        'message': message?.toString(),
        'level': levelsAllocation[level],
      };
}
