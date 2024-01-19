import 'inner_logger.dart';
import 'log_level.dart';
import 'log_message.dart';
import 'logger.dart';

/// {@nodoc}
base mixin InnerLoggerMethodsMixin on InnerLogger {
  @override
  void s(
    Object message, [
    LogMessageContext? context,
  ]) =>
      super.log(
        LogMessage.create(
          message,
          const LogLevel.shout(),
          context: context,
        ),
      );

  @override
  void v(
    Object message, [
    LogMessageContext? context,
  ]) =>
      super.log(
        LogMessage.create(
          message,
          const LogLevel.v(),
          context: context,
        ),
      );

  @override
  void e(
    Object message, [
    StackTrace? stackTrace,
    LogMessageContext? context,
  ]) =>
      super.log(
        LogMessage.create(
          message,
          const LogLevel.warning(),
          stackTrace: stackTrace,
          context: context,
        ),
      );

  @override
  void vv(
    Object message, [
    LogMessageContext? context,
  ]) =>
      super.log(
        LogMessage.create(
          message,
          const LogLevel.vv(),
          context: context,
        ),
      );

  @override
  void w(
    Object message, [
    StackTrace? stackTrace,
    LogMessageContext? context,
  ]) =>
      super.log(
        LogMessage.create(
          message,
          const LogLevel.warning(),
          stackTrace: stackTrace,
          context: context,
        ),
      );

  @override
  void vvv(
    Object message, [
    LogMessageContext? context,
  ]) =>
      super.log(
        LogMessage.create(
          message,
          const LogLevel.vvv(),
          context: context,
        ),
      );

  @override
  void i(
    Object message, [
    LogMessageContext? context,
  ]) =>
      super.log(
        LogMessage.create(
          message,
          const LogLevel.info(),
          context: context,
        ),
      );

  @override
  void vvvv(
    Object message, [
    LogMessageContext? context,
  ]) =>
      super.log(
        LogMessage.create(
          message,
          const LogLevel.vvvv(),
          context: context,
        ),
      );

  @override
  void d(
    Object message, [
    LogMessageContext? context,
  ]) =>
      super.log(
        LogMessage.create(
          message,
          const LogLevel.debug(),
          context: context,
        ),
      );

  @override
  void vvvvv(
    Object message, [
    LogMessageContext? context,
  ]) =>
      super.log(
        LogMessage.create(
          message,
          const LogLevel.vvvvv(),
          context: context,
        ),
      );

  @override
  void vvvvvv(
    Object message, [
    LogMessageContext? context,
  ]) =>
      super.log(
        LogMessage.create(
          message,
          const LogLevel.vvvvvv(),
          context: context,
        ),
      );
}
