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
  external void log(JSAny? arg);

  /// Logs a warning message to the console
  external void warn(JSAny? arg);

  /// Logs an error message to the console
  external void error(JSAny? arg);

  /// Logs an info message to the console
  external void info(JSAny? arg);

  /// Logs a debug message to the console
  external void debug(JSAny? arg);
}

/// The global window object
@JS()
@internal
external Window get window;

/// The global console object
@JS()
@internal
external Console get console;

/// Environment-specific implementation of [LogDelegate]
@internal
LogDelegate createEnvironmentLogDelegate() => LogDelegate$JS(window.console);

@internal
final class LogDelegate$JS implements LogDelegate {
  LogDelegate$JS(this.console);

  final MessageFormattingPipeline _formatter = MessageFormattingPipelineJS();

  @protected
  final Console console;

  @override
  void log(LogMessage event) {
    final output = _formatter.format(event);
    if (output == null) return;
    event.level.when<void>(
      shout: () => console.warn(output.toJS),
      v: () => console.log(output.toJS),
      error: () => console.error(output.toJS),
      vv: () => console.log(output.toJS),
      warning: () => console.warn(output.toJS),
      vvv: () => console.log(output.toJS),
      info: () => console.info(output.toJS),
      vvvv: () => console.log(output.toJS),
      debug: () => console.debug(output.toJS),
      vvvvv: () => console.log(output.toJS),
      vvvvvv: () => console.log(output.toJS),
    );
  }
}

/// Environment-specific implementation of [MessageFormattingPipeline]
@internal
final class MessageFormattingPipelineJS = MessageFormattingPipeline
    with MessageLogFormatterMixin;
