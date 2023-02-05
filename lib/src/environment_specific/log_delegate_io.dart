import 'dart:io' as io show Stdout, stdout;

import 'package:meta/meta.dart';

import '../log_level.dart';
import 'console_log_formatter_mixin.dart';
import 'log_delegate.dart';
import 'log_delegate_stub.dart';
import 'message_formatting_pipeline.dart';
import 'message_log_formatter_mixin.dart';

/// {@nodoc}
@internal
LogDelegate createEnvironmentLogDelegate() =>
    io.stdout.hasTerminal ? LogDelegateIO(io.stdout) : LogDelegateStub();

/// {@nodoc}
@internal
class LogDelegateIO implements LogDelegate {
  /// {@nodoc}
  LogDelegateIO(this.console);

  final MessageFormattingPipeline _formatter = MessageFormattingPipelineIO();

  /// {@nodoc}
  @protected
  final io.Stdout console;

  @override
  void log({
    required Object message,
    required LogLevel logLevel,
    required StackTrace? stackTrace,
  }) =>
      console.writeln(
        _formatter.format(
          message: message,
          logLevel: logLevel,
          stackTrace: stackTrace,
        ),
      );
}

/// {@nodoc}
@internal
class MessageFormattingPipelineIO extends MessageFormattingPipeline
    with ConsoleLogFormatterMixin, MessageLogFormatterMixin {}
