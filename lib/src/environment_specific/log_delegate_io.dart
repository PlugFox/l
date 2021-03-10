import 'dart:io' as io show Stdout, stdout;

import '../log_level.dart';
import 'console_log_formater.dart';
import 'log_delegate.dart';
import 'log_delegate_stub.dart';

/// {@nodoc}
LogDelegate createEnvironmentLogDelegate() {
  // ignore: close_sinks
  final console = io.stdout;
  if (console.hasTerminal) {
    return LogDelegateIO(console);
  } else {
    return LogDelegateStub();
  }
}

/// {@nodoc}
class LogDelegateIO implements LogDelegate {
  /// {@nodoc}
  final io.Stdout console;

  /// {@nodoc}
  LogDelegateIO(this.console);

  @override
  void log({
    required Object message,
    required LogLevel logLevel,
  }) =>
      console.writeln(
        consoleLogFormatter(
          message: message,
          logLevel: logLevel,
        ),
      );
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
