import 'inner_logger.dart';

/// {@nodoc}
mixin InnerLoggerOperatorsMixin on InnerLogger {
  @override
  void operator <(Object info) => super.i(info);

  @override
  void operator <<(Object debug) => super.d(debug);
}
