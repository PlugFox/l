import 'inner_logger.dart';
import 'log_level.dart';

/// {@nodoc}
mixin InnerLoggerMethodsMixin on InnerLogger {
  @override
  void s(Object message) => super.log(
        message: message,
        logLevel: const LogLevel.shout(),
      );

  @override
  void v(Object message) => super.log(
        message: message,
        logLevel: const LogLevel.v(),
      );

  @override
  void e(Object message, [StackTrace? stackTrace]) => super.log(
        message: message,
        logLevel: const LogLevel.error(),
        stackTrace: stackTrace,
      );

  @override
  void vv(Object message) => super.log(
        message: message,
        logLevel: const LogLevel.vv(),
      );

  @override
  void w(Object message, [StackTrace? stackTrace]) => super.log(
        message: message,
        logLevel: const LogLevel.warning(),
        stackTrace: stackTrace,
      );

  @override
  void vvv(Object message) => super.log(
        message: message,
        logLevel: const LogLevel.vvv(),
      );

  @override
  void i(Object message) => super.log(
        message: message,
        logLevel: const LogLevel.info(),
      );

  @override
  void vvvv(Object message) => super.log(
        message: message,
        logLevel: const LogLevel.vvvv(),
      );

  @override
  void d(Object message) => super.log(
        message: message,
        logLevel: const LogLevel.debug(),
      );

  @override
  void vvvvv(Object message) => super.log(
        message: message,
        logLevel: const LogLevel.vvvvv(),
      );

  @override
  void vvvvvv(Object message) => super.log(
        message: message,
        logLevel: const LogLevel.vvvvvv(),
      );
}
