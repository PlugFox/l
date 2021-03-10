import 'dart:html' as html show window, Console;

import '../log_level.dart';
import 'log_delegate.dart';

/// {@nodoc}
LogDelegate createEnvironmentLogDelegate() =>
    LogDelegateWeb(html.window.console);

/// {@nodoc}
class LogDelegateWeb implements LogDelegate {
  /// {@nodoc}
  final html.Console console;

  /// {@nodoc}
  LogDelegateWeb(this.console);

  @override
  void log({
    required Object message,
    required LogLevel logLevel,
  }) =>
      console.log('[${logLevel.prefix}] $message');
}
