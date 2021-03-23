import 'dart:async';

import 'inner_logger_log_mixin.dart';
import 'inner_logger_methods_mixin.dart';
import 'inner_logger_operators_mixin.dart';
import 'inner_logger_shortcuts_mixin.dart';
import 'inner_logger_subscription_mixin.dart';
import 'inner_print_handler_mixin.dart';
import 'log_level.dart';
import 'log_message.dart';
import 'logger.dart';

/// {@nodoc}
abstract class InnerLogger extends Stream<LogMessage> implements L {
  /// Print a message to the console
  /// {@nodoc}
  void log({required Object message, required LogLevel logLevel});

  /// Notify subscribers
  /// {@nodoc}
  void notifyListeners({required Object message, required LogLevel logLevel});
}

/// {@nodoc}
class InnerLoggerImpl extends InnerLogger
    with
        InnerLoggerSubscriptionMixin,
        InnerLoggerLogMixin,
        InnerLoggerMethodsMixin,
        InnerLoggerOperatorsMixin,
        InnerLoggerShortcutsMixin,
        InnerPrintHandlerMixin {
  //region InnerLoggerImpl singleton factory
  /// {@nodoc}
  factory InnerLoggerImpl() => _internalSingleton;
  static final InnerLoggerImpl _internalSingleton = InnerLoggerImpl._internal();
  InnerLoggerImpl._internal();
  //endregion
}
