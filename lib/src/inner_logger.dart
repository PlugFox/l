import 'dart:async';

import 'inner_logger_log_mixin.dart';
import 'inner_logger_methods_mixin.dart';
import 'inner_logger_operators_mixin.dart';
import 'inner_logger_subscription_mixin.dart';
import 'l.dart';
import 'log_level.dart';
import 'log_message.dart';

/// {@nodoc}
abstract class InnerLogger extends Stream<LogMessage> implements L {
  /// Add log to queue
  /// {@nodoc}
  void log({required Object message, required LogLevel logLevel});
}

/// {@nodoc}
class InnerLoggerImpl extends InnerLogger
    with
        InnerLoggerLogMixin,
        InnerLoggerMethodsMixin,
        InnerLoggerOperatorsMixin,
        InnerLoggerSubscriptionMixin {
  //region InnerLoggerImpl singleton factory
  /// {@nodoc}
  factory InnerLoggerImpl() => _internalSingleton;
  static final InnerLoggerImpl _internalSingleton = InnerLoggerImpl._internal();
  InnerLoggerImpl._internal();
  //endregion
}
