import '../log_level.dart';
import 'log_delegate.dart';

/// {@nodoc}
LogDelegate createEnvironmentLogDelegate() => LogDelegateStub();

/// {@nodoc}
class LogDelegateStub implements LogDelegate {
  @override
  void log({
    required Object message,
    required LogLevel logLevel,
  }) =>
      // ignore: avoid_print
      print(
          '$_esc${_fgColors['blue']}[${logLevel.prefix}]$_esc$_reset $message');
}

/// Ansi escape
const String _esc = '\x1B[';
const String _reset = '0m';

/// Ansi foreground colors for terminal
const Map<String, String> _fgColors = <String, String>{
  'black': '30m',
  'red': '31m',
  'green': '32m',
  'yellow': '33m',
  'blue': '34m',
  'magenta': '35m',
  'cyan': '36m',
  'white': '37m',
};

/// Ansi background colors for terminal
const Map<String, String> _bgColors = <String, String>{
  'black': '40m',
  'red': '41m',
  'green': '42m',
  'yellow': '43m',
  'blue': '44m',
  'magenta': '45m',
  'cyan': '46m',
  'white': '47m',
};

/// Ansi decorations for terminal
const Map<String, String> _decorations = <String, String>{
  'bold': '1m',
  'underline': '4m',
  'reversed': '7m',
};
