@internal

import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import '../inner_zoned_mixin.dart';
import '../log_level.dart';
import 'message_formatting_pipeline.dart';

/// {@nodoc}
@internal
mixin MessageLogFormatterMixin on MessageFormattingPipeline {
  @override
  String format({
    required Object message,
    required LogLevel logLevel,
    required Object? stackTrace,
  }) {
    final options = getCurrentLogOptions();

    Object formattedMessage;
    try {
      formattedMessage = options?.messageFormatting?.call(
            message,
            logLevel,
            DateTime.now(),
          ) ??
          message;
    } on Object catch (error) {
      debugger(
        message: 'Error "$error" while formatting message: $message',
      );
      formattedMessage = message;
    }

    Object? formattedStackTrace;
    try {
      if (stackTrace != null && (options?.printStackTrace ?? true)) {
        final stackTraceFormatting =
            options?.stackTraceFormatting ?? stack_trace.Trace.format;
        if (stackTrace is StackTrace) {
          formattedStackTrace = stackTraceFormatting(stackTrace);
        } else if (stackTrace is String) {
          formattedStackTrace =
              stackTraceFormatting(StackTrace.fromString(stackTrace));
        } else {
          formattedStackTrace = null;
        }
      } else {
        formattedStackTrace = null;
      }
    } on Object catch (error) {
      debugger(
        message: 'Error "$error" while formatting stackTrace: $stackTrace',
      );
      formattedStackTrace = null;
    }

    return super.format(
      message: formattedMessage,
      logLevel: logLevel,
      stackTrace: formattedStackTrace,
    );
  }
}
