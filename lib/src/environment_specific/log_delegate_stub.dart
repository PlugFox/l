import 'dart:async';

import 'package:meta/meta.dart';

import '../log_level.dart';
import 'console_log_formatter_mixin.dart';
import 'log_delegate.dart';
import 'message_formatting_pipeline.dart';
import 'message_log_formatting_mixin.dart';

/// {@nodoc}
@internal
LogDelegate createEnvironmentLogDelegate() => LogDelegate$Stub();

/// {@nodoc}
@internal
final class LogDelegate$Stub implements LogDelegate {
  /// {@nodoc}
  LogDelegate$Stub();

  final MessageFormattingPipeline _formatter = MessageFormattingPipelineStub();

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
    _printToConsole(output);
  }

  void _printToConsole(String line) => Zone.root.print(line);
}

/// {@nodoc}
@internal
final class MessageFormattingPipelineStub = MessageFormattingPipeline
    with ConsoleLogFormatterMixin, MessageLogFormatterMixin;
