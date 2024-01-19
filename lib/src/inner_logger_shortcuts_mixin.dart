import 'package:meta/meta.dart';

import 'inner_logger.dart';
import 'logger.dart';

/// Shortcuts for logging
@internal
base mixin InnerLoggerShortcutsMixin on InnerLogger {
  @override
  void v1(Object message, [LogMessageContext? context]) =>
      super.v(message, context);

  @override
  void v2(Object message, [LogMessageContext? context]) =>
      super.vv(message, context);

  @override
  void v3(Object message, [LogMessageContext? context]) =>
      super.vvv(message, context);

  @override
  void v4(Object message, [LogMessageContext? context]) =>
      super.vvvv(message, context);

  @override
  void v5(Object message, [LogMessageContext? context]) =>
      super.vvvvv(message, context);

  @override
  void v6(Object message, [LogMessageContext? context]) =>
      super.vvvvvv(message, context);
}
