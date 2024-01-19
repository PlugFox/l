import 'dart:html' as html show window, Console;

import 'package:meta/meta.dart';

import '../log_level.dart';
import 'log_delegate.dart';
import 'message_formatting_pipeline.dart';
import 'message_log_formatting_mixin.dart';

/// {@nodoc}
@internal
LogDelegate createEnvironmentLogDelegate() =>
    LogDelegate$JS(html.window.console);

/// {@nodoc}
@internal
final class LogDelegate$JS implements LogDelegate {
  /// {@nodoc}
  LogDelegate$JS(this.console);

  final MessageFormattingPipeline _formatter = MessageFormattingPipelineWeb();

  /// {@nodoc}
  @protected
  final html.Console console;

  @override
  void log({
    required Object message,
    required LogLevel logLevel,
    required DateTime timestamp,
  }) {
    final output = _formatter.format(
      message: message,
      logLevel: logLevel,
      timestamp: timestamp,
    );
    if (output == null) return;
    logLevel.when<void>(
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

/// {@nodoc}
@internal
final class MessageFormattingPipelineWeb = MessageFormattingPipeline
    with MessageLogFormatterMixin;
