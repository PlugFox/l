import 'environment_specific/log_delegate.dart';
import 'environment_specific/stub_log_delegate.dart';
import 'inner_logger.dart';
import 'log_level.dart';

/// {@nodoc}
mixin InnerLoggerLogMixin on InnerLogger {
  final LogDelegate _delegate = StubLogDelegate();

  @override
  void log({
    required Object message,
    required LogLevel logLevel,
  }) =>
      _delegate.log(
        message: message,
        logLevel: logLevel,
      );
}
