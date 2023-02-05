@internal

import 'dart:async';

import 'package:meta/meta.dart';

import '../log_level.dart';
import 'console_log_formatter_mixin.dart';
import 'log_delegate.dart';
import 'message_formatting_pipeline.dart';
import 'message_log_formatter_mixin.dart';

/// {@nodoc}
@internal
LogDelegate createEnvironmentLogDelegate() => LogDelegateStub();

/// {@nodoc}
@internal
class LogDelegateStub implements LogDelegate {
  final MessageFormattingPipeline _formatter = MessageFormattingPipelineStub();

  @override
  void log({
    required Object message,
    required LogLevel logLevel,
    required StackTrace? stackTrace,
  }) =>
      // ignore: avoid_print
      _printToConsole(
        _formatter.format(
          message: message,
          logLevel: logLevel,
          stackTrace: stackTrace,
        ),
      );

  void _printToConsole(String line) => Zone.root.print(line);
}

/// {@nodoc}
@internal
class MessageFormattingPipelineStub extends MessageFormattingPipeline
    with ConsoleLogFormatterMixin, MessageLogFormatterMixin {}
