import 'environment_specific/log_delegate.dart';
import 'environment_specific/log_delegate_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'environment_specific/log_delegate_web.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'environment_specific/log_delegate_io.dart';
import 'inner_logger.dart';
import 'log_message.dart';

/// {@nodoc}
mixin InnerLoggerLogMixin on InnerLogger {
  final LogDelegate? _delegate = () {
    // Without log delegate when release
    if (const bool.fromEnvironment(
      'dart.vm.product',
      defaultValue: true,
    )) return null;
    return createEnvironmentLogDelegate();
  }();

  @override
  void log(LogMessage logMessage) {
    _delegate?.log(
      message: logMessage.message,
      logLevel: logMessage.level,
    );
    super.notifyListeners(logMessage);
  }
}
