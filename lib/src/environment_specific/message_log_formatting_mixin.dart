import 'package:meta/meta.dart';

import '../inner_zoned_mixin.dart';
import '../log_level.dart';
import '../log_options.dart';
import 'message_formatting_pipeline.dart';

/// {@nodoc}
@internal
base mixin MessageLogFormatterMixin on MessageFormattingPipeline {
  @override
  String? format({
    required Object message,
    required LogLevel logLevel,
    required DateTime timestamp,
  }) {
    final currentLogOptions = getCurrentLogOptions();
    Object? output;
    if (currentLogOptions != null) {
      final LogOptions(:messageFormatting, :overrideOutput) = currentLogOptions;
      // Format the source message
      output = messageFormatting?.call(message, logLevel, timestamp);
      if (overrideOutput != null) {
        // Override the message and output it only if it is not null
        return overrideOutput(output ?? message, logLevel, timestamp);
      }
    }
    // Standard formatting and output
    return super.format(
      message: output ?? message,
      logLevel: logLevel,
      timestamp: timestamp,
    );
  }
}
