import 'package:meta/meta.dart';

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
    final formattedMessage = getCurrentLogOptions()?.messageFormatting?.call(
              message,
              logLevel,
              DateTime.now(),
            ) ??
        message;

    final formattedStackTrace = stackTrace != null
        ? getCurrentLogOptions()
            ?.stackTraceFormatting
            ?.call(stackTrace as StackTrace)
        : null;
    return super.format(
      message: formattedMessage,
      logLevel: logLevel,
      stackTrace: formattedStackTrace,
    );
  }
}
