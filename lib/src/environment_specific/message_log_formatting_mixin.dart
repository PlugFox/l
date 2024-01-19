import 'package:meta/meta.dart';

import '../inner_zoned_mixin.dart';
import '../log_message.dart';
import '../log_options.dart';
import 'message_formatting_pipeline.dart';

/// {@nodoc}
@internal
base mixin MessageLogFormatterMixin on MessageFormattingPipeline {
  @override
  String? format(LogMessage event) {
    final currentLogOptions = getCurrentLogOptions();
    var output = event;
    if (currentLogOptions != null) {
      final LogOptions(:messageFormatting, :overrideOutput) = currentLogOptions;
      // Format the source message
      if (messageFormatting != null) {
        output = output.copyWith(message: messageFormatting(output));
      }
      // Override the message and output it only if it is not null
      if (overrideOutput != null) {
        return overrideOutput(output);
      }
    }
    // Standard formatting and output
    return super.format(output);
  }
}
