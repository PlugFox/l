import 'dart:async';

import 'package:meta/meta.dart';

import 'inner_logger_log_mixin.dart';
import 'inner_logger_methods_mixin.dart';
import 'inner_logger_operators_mixin.dart';
import 'inner_logger_shortcuts_mixin.dart';
import 'inner_logger_subscription_mixin.dart';
import 'inner_zoned_mixin.dart';
import 'log_level.dart';
import 'log_message.dart';
import 'logger.dart';

/// {@nodoc}
@internal
abstract class InnerLogger extends Stream<LogMessage> implements L {
  /// Print a message to the console
  /// {@nodoc}
  @protected
  @visibleForOverriding
  void log({required Object message, required LogLevel logLevel});

  /// Notify subscribers
  /// {@nodoc}
  @protected
  @visibleForOverriding
  void notifyListeners({required Object message, required LogLevel logLevel});
}

/// {@nodoc}
@internal
class InnerLoggerImpl extends InnerLogger
    with
        InnerLoggerSubscriptionMixin,
        InnerLoggerLogMixin,
        InnerLoggerMethodsMixin,
        InnerLoggerOperatorsMixin,
        InnerLoggerShortcutsMixin,
        InnerZonedMixin {
  //region InnerLoggerImpl singleton factory
  /// {@nodoc}
  factory InnerLoggerImpl() => _internalSingleton;
  static final InnerLoggerImpl _internalSingleton = InnerLoggerImpl._internal();
  InnerLoggerImpl._internal();
  //endregion
}
