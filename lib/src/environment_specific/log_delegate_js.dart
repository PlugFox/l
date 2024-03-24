import 'dart:html' as html show window, Console;

import 'package:meta/meta.dart';

import '../log_message.dart';
import '../log_options.dart';
import 'log_delegate.dart';
import 'log_delegate_stub.dart';
import 'message_formatting_pipeline.dart';
import 'message_log_formatting_mixin.dart';

/// Environment-specific implementation of [LogDelegate]
@internal
LogDelegate createEnvironmentLogDelegate([LogOptions? options]) {
  if (options?.useHtmlConsoleInWeb ?? true) {
    return LogDelegate$JS(html.window.console);
  }
  return LogDelegate$Stub();
}

@internal
final class LogDelegate$JS implements LogDelegate {
  LogDelegate$JS(this.console);

  final MessageFormattingPipeline _formatter = MessageFormattingPipelineWeb();

  @protected
  final html.Console console;

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
