import 'package:meta/meta.dart';

import '../log_level.dart';

/// {@nodoc}
@internal
String consoleLogFormatter({
  required Object message,
  required LogLevel logLevel,
}) =>
    logLevel.when<String>(
      shout: () => _shout(message, logLevel.prefix),
      v: () => _v(message, logLevel.prefix),
      error: () => _error(message, logLevel.prefix),
      vv: () => _vv(message, logLevel.prefix),
      warning: () => _warning(message, logLevel.prefix),
      vvv: () => _vvv(message, logLevel.prefix),
      info: () => _info(message, logLevel.prefix),
      vvvv: () => _vvvv(message, logLevel.prefix),
      debug: () => _debug(message, logLevel.prefix),
      vvvvv: () => _vvvvv(message, logLevel.prefix),
      vvvvvv: () => _vvvvvv(message, logLevel.prefix),
    );

String _shout(Object message, String prefix) => (StringBuffer('[')
      ..write(_esc)
      ..write(_ConsoleFont.underline.value) // font
      ..write(_esc)
      ..write(_ConsoleColor.black.foregroundValue) // foreground
      ..write(_esc)
      ..write(_ConsoleColor.white.backgroundValue) // background
      ..write(prefix)
      ..write(_esc)
      ..write(_reset)
      ..write(']')
      ..write(' ')
      ..write(message))
    .toString();

String _v(Object message, String prefix) => (StringBuffer('[')
      ..write(_esc)
      ..write(_ConsoleFont.bold.value) // font
      ..write(_esc)
      ..write(_ConsoleColor.magenta.foregroundValue) // foreground
      ..write('') // background
      ..write(prefix)
      ..write(_esc)
      ..write(_reset)
      ..write(']')
      ..write(' ')
      ..write(message))
    .toString();

String _error(Object message, String prefix) => (StringBuffer('[')
      ..write(_esc)
      ..write(_ConsoleFont.bold.value) // font
      ..write(_esc)
      ..write(_ConsoleColor.red.foregroundValue) // foreground
      ..write(prefix)
      ..write(_esc)
      ..write(_reset)
      ..write(']')
      ..write(' ')
      ..write(message))
    .toString();

String _vv(Object message, String prefix) =>
    (StringBuffer('[')..write(prefix)..write(']')..write(' ')..write(message))
        .toString();

String _warning(Object message, String prefix) => (StringBuffer('[')
      ..write(_esc)
      ..write(_ConsoleColor.yellow.foregroundValue) // foreground
      ..write(prefix)
      ..write(_esc)
      ..write(_reset)
      ..write(']')
      ..write(' ')
      ..write(message))
    .toString();

String _vvv(Object message, String prefix) =>
    (StringBuffer('[')..write(prefix)..write(']')..write(' ')..write(message))
        .toString();

String _info(Object message, String prefix) => (StringBuffer('[')
      ..write(_esc)
      ..write(_ConsoleColor.green.foregroundValue) // foreground
      ..write(prefix)
      ..write(_esc)
      ..write(_reset)
      ..write(']')
      ..write(' ')
      ..write(message))
    .toString();

String _vvvv(Object message, String prefix) =>
    (StringBuffer('[')..write(prefix)..write(']')..write(' ')..write(message))
        .toString();

String _debug(Object message, String prefix) => (StringBuffer('[')
      ..write(_esc)
      ..write(_ConsoleColor.cyan.foregroundValue) // foreground
      ..write(prefix)
      ..write(_esc)
      ..write(_reset)
      ..write(']')
      ..write(' ')
      ..write(message))
    .toString();

String _vvvvv(Object message, String prefix) =>
    (StringBuffer('[')..write(prefix)..write(']')..write(' ')..write(message))
        .toString();

String _vvvvvv(Object message, String prefix) =>
    (StringBuffer('[')..write(prefix)..write(']')..write(' ')..write(message))
        .toString();

/// Ansi escape
const String _esc = '\x1B[';

/// Ansi reset
const String _reset = '0m';

/// Available console colors
enum _ConsoleColor {
  black,
  red,
  green,
  yellow,
  blue,
  magenta,
  cyan,
  white,
  byDefault,
}

extension _ConsoleColorX on _ConsoleColor {
  /// Ansi foreground colors for terminal
  String get foregroundValue {
    switch (this) {
      case _ConsoleColor.black:
        return '30m';
      case _ConsoleColor.red:
        return '31m';
      case _ConsoleColor.green:
        return '32m';
      case _ConsoleColor.yellow:
        return '33m';
      case _ConsoleColor.blue:
        return '34m';
      case _ConsoleColor.magenta:
        return '35m';
      case _ConsoleColor.cyan:
        return '36m';
      case _ConsoleColor.white:
        return '37m';
      case _ConsoleColor.byDefault:
      default:
        return '';
    }
  }

  /// Ansi background colors for terminal
  String get backgroundValue {
    switch (this) {
      case _ConsoleColor.black:
        return '40m';
      case _ConsoleColor.red:
        return '41m';
      case _ConsoleColor.green:
        return '42m';
      case _ConsoleColor.yellow:
        return '43m';
      case _ConsoleColor.blue:
        return '44m';
      case _ConsoleColor.magenta:
        return '45m';
      case _ConsoleColor.cyan:
        return '46m';
      case _ConsoleColor.white:
        return '47m';
      case _ConsoleColor.byDefault:
      default:
        return '';
    }
  }
}

/// Available console fonts
enum _ConsoleFont {
  bold,
  underline,
  reversed,
  byDefault,
}

extension _ConsoleFontX on _ConsoleFont {
  /// Ansi decorations for terminal
  String get value {
    switch (this) {
      case _ConsoleFont.bold:
        return '1m';
      case _ConsoleFont.underline:
        return '4m';
      case _ConsoleFont.reversed:
        return '7m';
      case _ConsoleFont.byDefault:
      default:
        return '';
    }
  }
}
