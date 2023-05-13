import 'inner_logger.dart';
import 'log_level.dart';
import 'log_message.dart';

/// {@nodoc}
base mixin InnerLoggerMethodsMixin on InnerLogger {
  @override
  void s(Object message) => super.log(
        LogMessage.create(
          message,
          const LogLevel.shout(),
        ),
      );

  @override
  void v(Object message) => super.log(
        LogMessage.create(
          message,
          const LogLevel.v(),
        ),
      );

  @override
  void e(Object message, [StackTrace? stackTrace]) => super.log(
        stackTrace == null
            ? LogMessage.create(
                message,
                const LogLevel.error(),
              )
            : LogMessageWithStackTrace.create(
                message,
                const LogLevel.error(),
                stackTrace,
              ),
      );

  @override
  void vv(Object message) => super.log(
        LogMessage.create(
          message,
          const LogLevel.vv(),
        ),
      );

  @override
  void w(Object message, [StackTrace? stackTrace]) => super.log(
        stackTrace == null
            ? LogMessage.create(
                message,
                const LogLevel.warning(),
              )
            : LogMessageWithStackTrace.create(
                message,
                const LogLevel.warning(),
                stackTrace,
              ),
      );

  @override
  void vvv(Object message) => super.log(
        LogMessage.create(
          message,
          const LogLevel.vvv(),
        ),
      );

  @override
  void i(Object message) => super.log(
        LogMessage.create(
          message,
          const LogLevel.info(),
        ),
      );

  @override
  void vvvv(Object message) => super.log(
        LogMessage.create(
          message,
          const LogLevel.vvvv(),
        ),
      );

  @override
  void d(Object message) => super.log(
        LogMessage.create(
          message,
          const LogLevel.debug(),
        ),
      );

  @override
  void vvvvv(Object message) => super.log(
        LogMessage.create(
          message,
          const LogLevel.vvvvv(),
        ),
      );

  @override
  void vvvvvv(Object message) => super.log(
        LogMessage.create(
          message,
          const LogLevel.vvvvvv(),
        ),
      );
}
