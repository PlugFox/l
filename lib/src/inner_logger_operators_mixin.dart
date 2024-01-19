import 'package:meta/meta.dart';

import 'inner_logger.dart';

/// Operators for logging
@internal
base mixin InnerLoggerOperatorsMixin on InnerLogger {
  @override
  void operator <(Object info) => super.i(info);

  @override
  void operator <<(Object debug) => super.d(debug);
}
