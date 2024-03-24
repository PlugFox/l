import 'package:meta/meta.dart';

import 'environment_specific/log_delegate.dart';
import 'environment_specific/log_delegate_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'environment_specific/log_delegate_js.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'environment_specific/log_delegate_vm.dart';
import 'inner_logger.dart';
import 'inner_zoned_mixin.dart';
import 'log_message.dart';

// ignore: do_not_use_environment
const bool _kIsDebug = !bool.fromEnvironment(
  'dart.vm.product',
  defaultValue: true,
);

/// Log mixin for [InnerLogger]
@internal
base mixin InnerLoggerLogMixin on InnerLogger {
  late final LogDelegate _delegate =
      createEnvironmentLogDelegate(getCurrentLogOptions());

  @override
  void log(LogMessage event) {
    // Without log delegate when release
    if (_kIsDebug || (getCurrentLogOptions()?.outputInRelease ?? false)) {
      _delegate.log(event);
    }
    super.notifyListeners(event);
  }
}
