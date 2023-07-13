import 'package:meta/meta.dart';

import '../log_level.dart';

/// {@nodoc}
@internal
abstract base class MessageFormattingPipeline {
  /// {@nodoc}
  @internal
  String? format({
    required Object message,
    required LogLevel logLevel,
    required DateTime date,
  }) =>
      message.toString();
}
