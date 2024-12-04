import 'package:meta/meta.dart';

import '../l.dart';
import 'environment_specific/log_delegate.dart';
import 'environment_specific/log_delegate_developer.dart' as delegate_developer;
import 'environment_specific/log_delegate_ignore.dart' as delegate_ignore;
import 'environment_specific/log_delegate_print.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'environment_specific/log_delegate_js.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'environment_specific/log_delegate_vm.dart'
    as delegate_platform;
import 'environment_specific/log_delegate_print.dart' as delegate_print;
import 'inner_logger.dart';
import 'inner_zoned_mixin.dart';

// ignore: do_not_use_environment
const bool _kIsDebug = !bool.fromEnvironment(
  'dart.vm.product',
  defaultValue: true,
);

/// Log mixin for [InnerLogger]
@internal
base mixin InnerLoggerLogMixin on InnerLogger {
  static final LogDelegate _platformDelegate =
      delegate_platform.createEnvironmentLogDelegate();
  static final LogDelegate _printDelegate = delegate_print.LogDelegate$Print();
  static final LogDelegate _developerDelegate =
      delegate_developer.LogDelegate$Developer();
  static final LogDelegate _ignoreDelegate =
      delegate_ignore.LogDelegate$Ignore();

  @override
  void log(LogMessage event) {
    final options = getCurrentLogOptions() ?? LogOptions.defaultOptions;
    if (_kIsDebug || options.outputInRelease) {
      switch (options.output) {
        case LogOutput.platform:
          _platformDelegate.log(event);
        case LogOutput.print:
          _printDelegate.log(event);
        case LogOutput.developer:
          _developerDelegate.log(event);
        case LogOutput.ignore:
          _ignoreDelegate.log(event);
      }
    }
    super.notifyListeners(event);
  }
}
