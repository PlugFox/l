import 'dart:async';

import 'package:meta/meta.dart';

import '../../l.dart';
import 'console_log_formatter_mixin.dart';
import 'log_delegate.dart';
import 'message_formatting_pipeline.dart';
import 'message_log_formatting_mixin.dart';

/// Environment-specific implementation of [LogDelegate]
@internal
LogDelegate createEnvironmentLogDelegate() => LogDelegate$Print();

@internal
final class LogDelegate$Print implements LogDelegate {
  LogDelegate$Print();

  final MessageFormattingPipeline _formatter = MessageFormattingPipelinePrint();

  @override
  void log(LogMessage event) {
    final output = _formatter.format(event);
    if (output == null) return;
    _printToConsole(output);
  }

  void _printToConsole(String line) => Zone.root.print(line);
}

/// Message formatting pipeline for printing to the console
@internal
final class MessageFormattingPipelinePrint = MessageFormattingPipeline
    with ConsoleLogFormatterMixin, MessageLogFormatterMixin;
