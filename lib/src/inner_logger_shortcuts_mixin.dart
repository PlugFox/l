import 'inner_logger.dart';

/// {@nodoc}
base mixin InnerLoggerShortcutsMixin on InnerLogger {
  @override
  void v1(Object message) => super.v(message);

  @override
  void v2(Object message) => super.vv(message);

  @override
  void v3(Object message) => super.vvv(message);

  @override
  void v4(Object message) => super.vvvv(message);

  @override
  void v5(Object message) => super.vvvvv(message);

  @override
  void v6(Object message) => super.vvvvvv(message);
}
