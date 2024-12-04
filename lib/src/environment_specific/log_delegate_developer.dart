import 'dart:developer' as developer;

import 'package:meta/meta.dart';

import '../../l.dart';
import 'console_log_formatter_mixin.dart';
import 'log_delegate.dart';
import 'message_formatting_pipeline.dart';
import 'message_log_formatting_mixin.dart';

/// Environment-specific implementation of [LogDelegate]
@internal
LogDelegate createEnvironmentLogDelegate() => LogDelegate$Developer();

@internal
final class LogDelegate$Developer implements LogDelegate {
  LogDelegate$Developer();

  final MessageFormattingPipeline _formatter =
      MessageFormattingPipelineDeveloper();

  @override
  void log(LogMessage event) {
    final output = _formatter.format(event);
    if (output == null) return;
    event.level.when<void>(
      shout: () => developer.log(output, level: 2000),
      v: () => developer.log(output, level: 1000),
      error: () => developer.log(output, level: 1000),
      vv: () => developer.log(output, level: 900),
      warning: () => developer.log(output, level: 900),
      vvv: () => developer.log(output, level: 800),
      info: () => developer.log(output, level: 800),
      vvvv: () => developer.log(output, level: 700),
      debug: () => developer.log(output, level: 700),
      vvvvv: () => developer.log(output, level: 400),
      vvvvvv: () => developer.log(output, level: 300),
    );
  }
}

/// Message formatting pipeline for printing to the console
@internal
final class MessageFormattingPipelineDeveloper = MessageFormattingPipeline
    with ConsoleLogFormatterMixin, MessageLogFormatterMixin;
