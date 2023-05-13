import 'dart:async';

import 'package:meta/meta.dart';

import 'inner_logger_log_mixin.dart';
import 'inner_logger_methods_mixin.dart';
import 'inner_logger_operators_mixin.dart';
import 'inner_logger_shortcuts_mixin.dart';
import 'inner_logger_subscription_mixin.dart';
import 'inner_zoned_mixin.dart';
import 'log_message.dart';
import 'logger.dart';

/// {@nodoc}
@internal
abstract base class InnerLogger extends Stream<LogMessage> implements L {
  /// Print a message to the console
  /// {@nodoc}
  @protected
  @visibleForOverriding
  void log(LogMessage logMessage);

  /// Notify subscribers
  /// {@nodoc}
  @protected
  @visibleForOverriding
  void notifyListeners(LogMessage logMessage);
}

/// {@nodoc}
@internal
final class InnerLoggerImpl extends InnerLogger
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
  InnerLoggerImpl._internal();
  static final InnerLoggerImpl _internalSingleton = InnerLoggerImpl._internal();
  //endregion
}
