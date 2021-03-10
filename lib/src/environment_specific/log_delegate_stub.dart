import '../log_level.dart';
import 'console_log_formater.dart';
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
        consoleLogFormatter(
          message: message,
          logLevel: logLevel,
        ),
      );
}
