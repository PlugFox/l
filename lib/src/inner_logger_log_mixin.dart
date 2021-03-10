import 'environment_specific/log_delegate.dart';
import 'environment_specific/log_delegate_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'environment_specific/log_delegate_web.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'environment_specific/log_delegate_io.dart';
import 'inner_logger.dart';
import 'log_level.dart';

/// {@nodoc}
mixin InnerLoggerLogMixin on InnerLogger {
  final LogDelegate _delegate = createEnvironmentLogDelegate();

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
