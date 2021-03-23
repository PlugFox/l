import 'package:meta/meta.dart';

import '../inner_zoned_mixin.dart';
import '../log_level.dart';
import 'message_formatting_pipeline.dart';

/// {@nodoc}
@internal
mixin MessageLogFormatterMixin on MessageFormattingPipeline {
  @override
  String format({required Object message, required LogLevel logLevel}) {
    final formattedMessage = getCurrentLogOptions()?.messageFormatting?.call(
              message,
              logLevel,
              DateTime.now(),
            ) ??
        message;
    return super.format(message: formattedMessage, logLevel: logLevel);
  }
}
