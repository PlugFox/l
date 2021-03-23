import 'package:meta/meta.dart';

import '../log_level.dart';
import 'console_log_formatter.dart';
import 'log_delegate.dart';
import 'message_formatting.dart';

/// {@nodoc}
@internal
LogDelegate createEnvironmentLogDelegate() => LogDelegateStub();

/// {@nodoc}
@internal
class LogDelegateStub implements LogDelegate {
  @override
  void log({
    required Object message,
    required LogLevel logLevel,
  }) =>
      // ignore: avoid_print
      print(
        consoleLogFormatter(
          message: messageLogFormatter(
            message: message,
            logLevel: logLevel,
          ),
          logLevel: logLevel,
        ),
      );
}
