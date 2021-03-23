import 'package:meta/meta.dart';

import '../log_level.dart';

/// {@nodoc}
@internal
abstract class MessageFormattingPipeline {
  /// {@nodoc}
  @internal
  String format({
    required Object message,
    required LogLevel logLevel,
  }) =>
      message.toString();
}
