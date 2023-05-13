import 'dart:html' as html show window, Console;

import 'package:meta/meta.dart';

import '../log_level.dart';
import 'log_delegate.dart';
import 'message_formatting_pipeline.dart';
import 'message_log_formatting_mixin.dart';

/// {@nodoc}
@internal
LogDelegate createEnvironmentLogDelegate() =>
    LogDelegate$Web(html.window.console);

/// {@nodoc}
@internal
final class LogDelegate$Web implements LogDelegate {
  /// {@nodoc}
  LogDelegate$Web(this.console);

  final MessageFormattingPipeline _formatter = MessageFormattingPipelineWeb();

  /// {@nodoc}
  @protected
  final html.Console console;

  @override
  void log({
    required Object message,
    required LogLevel logLevel,
  }) {
    final formattedMessage = _formatter.format(
      message: message,
      logLevel: logLevel,
    );
    logLevel.when<void>(
      shout: () => console.warn(formattedMessage),
      v: () => console.log(formattedMessage),
      error: () => console.error(formattedMessage),
      vv: () => console.log(formattedMessage),
      warning: () => console.warn(formattedMessage),
      vvv: () => console.log(formattedMessage),
      info: () => console.info(formattedMessage),
      vvvv: () => console.log(formattedMessage),
      debug: () => console.debug(formattedMessage),
      vvvvv: () => console.log(formattedMessage),
      vvvvvv: () => console.log(formattedMessage),
    );
  }
}

/// {@nodoc}
@internal
final class MessageFormattingPipelineWeb = MessageFormattingPipeline
    with MessageLogFormatterMixin;
