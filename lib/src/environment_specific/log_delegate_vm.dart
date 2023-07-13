import 'dart:io' as io show Stdout, stdout;

import 'package:meta/meta.dart';

import '../log_level.dart';
import 'console_log_formatter_mixin.dart';
import 'log_delegate.dart';
import 'log_delegate_stub.dart';
import 'message_formatting_pipeline.dart';
import 'message_log_formatting_mixin.dart';

/// {@nodoc}
@internal
LogDelegate createEnvironmentLogDelegate() =>
    io.stdout.hasTerminal ? LogDelegate$VM(io.stdout) : LogDelegate$Stub();

/// {@nodoc}
@internal
final class LogDelegate$VM implements LogDelegate {
  /// {@nodoc}
  LogDelegate$VM(this.console);

  final MessageFormattingPipeline _formatter = MessageFormattingPipelineIO();

  /// {@nodoc}
  @protected
  final io.Stdout console;

  @override
  void log({
    required Object message,
    required LogLevel logLevel,
    required DateTime date,
  }) {
    final output = _formatter.format(
      message: message,
      logLevel: logLevel,
      date: date,
    );
    if (output == null) return;
    console.writeln(output);
  }
}

/// {@nodoc}
@internal
final class MessageFormattingPipelineIO = MessageFormattingPipeline
    with ConsoleLogFormatterMixin, MessageLogFormatterMixin;
