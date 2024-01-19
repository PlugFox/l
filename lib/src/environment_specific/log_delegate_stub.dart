import 'dart:async';

import 'package:meta/meta.dart';

import '../../l.dart';
import 'console_log_formatter_mixin.dart';
import 'log_delegate.dart';
import 'message_formatting_pipeline.dart';
import 'message_log_formatting_mixin.dart';

/// Environment-specific implementation of [LogDelegate]
@internal
LogDelegate createEnvironmentLogDelegate() => LogDelegate$Stub();

@internal
final class LogDelegate$Stub implements LogDelegate {
  LogDelegate$Stub();

  final MessageFormattingPipeline _formatter = MessageFormattingPipelineStub();

  @override
  void log(LogMessage event) {
    final output = _formatter.format(event);
    if (output == null) return;
    _printToConsole(output);
  }

  void _printToConsole(String line) => Zone.root.print(line);
}

/// Environment-specific implementation of [MessageFormattingPipeline]
@internal
final class MessageFormattingPipelineStub = MessageFormattingPipeline
    with ConsoleLogFormatterMixin, MessageLogFormatterMixin;
