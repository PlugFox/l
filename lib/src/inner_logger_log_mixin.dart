import 'environment_specific/log_delegate.dart';
import 'environment_specific/log_delegate_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'environment_specific/log_delegate_web.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'environment_specific/log_delegate_io.dart';
import 'inner_logger.dart';
import 'inner_zoned_mixin.dart';
import 'log_message.dart';

const bool _kIsDebug = !bool.fromEnvironment(
  'dart.vm.product',
  defaultValue: true,
);

/// {@nodoc}
mixin InnerLoggerLogMixin on InnerLogger {
  final LogDelegate? _delegate = createEnvironmentLogDelegate();

  @override
  void log(LogMessage logMessage) {
    // Without log delegate when release
    if (_kIsDebug || (getCurrentLogOptions()?.outputInRelease ?? false)) {
      _delegate?.log(
        message: logMessage.message,
        logLevel: logMessage.level,
      );
    }
    super.notifyListeners(logMessage);
  }
}
