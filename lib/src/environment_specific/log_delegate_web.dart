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
      logLevel.when<void>(
        shout: () => console.warn(message),
        v: () => console.log(message),
        error: () => console.error(message),
        vv: () => console.log(message),
        warning: () => console.warn(message),
        vvv: () => console.log(message),
        info: () => console.info(message),
        vvvv: () => console.log(message),
        debug: () => console.debug(message),
        vvvvv: () => console.log(message),
        vvvvvv: () => console.log(message),
      );
}
