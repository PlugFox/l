import 'dart:io' as io show Stdout, stdout;

import 'package:meta/meta.dart';

import '../../l.dart';
import 'console_log_formatter_mixin.dart';
import 'log_delegate.dart';
import 'log_delegate_stub.dart';
import 'message_formatting_pipeline.dart';
import 'message_log_formatting_mixin.dart';

/// Environment-specific implementation of [LogDelegate]
@internal
LogDelegate createEnvironmentLogDelegate([LogOptions? options]) =>
    io.stdout.hasTerminal ? LogDelegate$VM(io.stdout) : LogDelegate$Stub();

@internal
final class LogDelegate$VM implements LogDelegate {
  LogDelegate$VM(this.console);

  final MessageFormattingPipeline _formatter = MessageFormattingPipelineIO();

  @protected
  final io.Stdout console;

  @override
  void log(LogMessage event) {
    final output = _formatter.format(event);
    if (output == null) return;
    console.writeln(output);
  }
}

/// Environment-specific implementation of [MessageFormattingPipeline]
@internal
final class MessageFormattingPipelineIO = MessageFormattingPipeline
    with ConsoleLogFormatterMixin, MessageLogFormatterMixin;
