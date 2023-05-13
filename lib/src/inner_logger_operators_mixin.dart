import 'inner_logger.dart';

/// {@nodoc}
base mixin InnerLoggerOperatorsMixin on InnerLogger {
  @override
  void operator <(Object info) => super.i(info);

  @override
  void operator <<(Object debug) => super.d(debug);
}
