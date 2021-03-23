import 'dart:io' as io show Stdout, stdout;

import '../log_level.dart';
import 'console_log_formater.dart';
import 'log_delegate.dart';

/// {@nodoc}
LogDelegate createEnvironmentLogDelegate() => LogDelegateIO(io.stdout);

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
