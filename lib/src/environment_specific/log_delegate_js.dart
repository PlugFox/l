import 'dart:js_interop';

import 'package:meta/meta.dart';

import '../log_message.dart';
import 'log_delegate.dart';
import 'message_formatting_pipeline.dart';
import 'message_log_formatting_mixin.dart';

/// The window object
@internal
extension type Window._(JSObject _) {
  /// Returns the console object
  external Console get console;
}

/// The console object
@internal
extension type Console._(JSObject _) {
  /// Logs a message to the console
  external void log(Object? arg);

  /// Logs a warning message to the console
  external void warn(Object? arg);

  /// Logs an error message to the console
  external void error(Object? arg);

  /// Logs an info message to the console
  external void info(Object? arg);

  /// Logs a debug message to the console
  external void debug(Object? arg);
}

/// The global window object
@JS()
@internal
external Window get window;

/// Environment-specific implementation of [LogDelegate]
@internal
LogDelegate createEnvironmentLogDelegate() => LogDelegate$JS(window.console);

@internal
final class LogDelegate$JS implements LogDelegate {
  LogDelegate$JS(this.console);

  final MessageFormattingPipeline _formatter = MessageFormattingPipelineWeb();

  @protected
  final Console console;

  @override
  void log(LogMessage event) {
    final output = _formatter.format(event);
    if (output == null) return;
    event.level.when<void>(
      shout: () => console.warn(output),
      v: () => console.log(output),
      error: () => console.error(output),
      vv: () => console.log(output),
      warning: () => console.warn(output),
      vvv: () => console.log(output),
      info: () => console.info(output),
      vvvv: () => console.log(output),
      debug: () => console.debug(output),
      vvvvv: () => console.log(output),
      vvvvvv: () => console.log(output),
    );
  }
}

/// Environment-specific implementation of [MessageFormattingPipeline]
@internal
final class MessageFormattingPipelineWeb = MessageFormattingPipeline
    with MessageLogFormatterMixin;
