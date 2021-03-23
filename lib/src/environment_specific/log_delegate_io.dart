import 'dart:io' as io show Stdout, stdout;

import 'package:meta/meta.dart';

import '../log_level.dart';
import 'console_log_formatter.dart';
import 'log_delegate.dart';
import 'message_formatting.dart';

/// {@nodoc}
@internal
LogDelegate createEnvironmentLogDelegate() => LogDelegateIO(io.stdout);

/// {@nodoc}
@internal
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
          message: messageLogFormatter(
            message: message,
            logLevel: logLevel,
          ),
          logLevel: logLevel,
        ),
      );
}
