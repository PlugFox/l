import '../log_level.dart';
import 'log_delegate.dart';

/// {@nodoc}
LogDelegate createEnvironmentLogDelegate() => LogDelegateIO();

/// {@nodoc}
class LogDelegateIO implements LogDelegate {
  @override
  void log({
    required Object message,
    required LogLevel logLevel,
  }) {
    // ignore: avoid_print
    print('[${logLevel.prefix}] $message');
  }
}
