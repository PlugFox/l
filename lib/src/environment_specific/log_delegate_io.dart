import 'dart:io' as io show Stdout, stdout;

import 'package:meta/meta.dart';

import '../log_level.dart';
import 'console_log_formatter_mixin.dart';
import 'log_delegate.dart';
import 'message_formatting_pipeline.dart';
import 'message_log_formatting_mixin.dart';

/// {@nodoc}
@internal
LogDelegate createEnvironmentLogDelegate() => LogDelegateIO(io.stdout);

/// {@nodoc}
@internal
class LogDelegateIO implements LogDelegate {
  final MessageFormattingPipeline _formatter = MessageFormattingPipelineIO();

  /// {@nodoc}
  @protected
  final io.Stdout console;

  /// {@nodoc}
  LogDelegateIO(this.console);

  @override
  void log({
    required Object message,
    required LogLevel logLevel,
  }) =>
      console.writeln(
        _formatter.format(
          message: message,
          logLevel: logLevel,
        ),
      );
}

/// {@nodoc}
@internal
class MessageFormattingPipelineIO extends MessageFormattingPipeline
    with ConsoleLogFormatterMixin, MessageLogFormatterMixin {}
