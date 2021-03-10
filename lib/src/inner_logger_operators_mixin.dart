import 'inner_logger.dart';

/// {@nodoc}
mixin InnerLoggerOperatorsMixin on InnerLogger {
  @override
  void operator <(Object info) => i(info);

  @override
  void operator <<(Object debug) => d(debug);
}
