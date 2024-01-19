import 'package:meta/meta.dart';

import '../log_message.dart';

/// {@nodoc}
@internal
abstract base class MessageFormattingPipeline {
  /// {@nodoc}
  @internal
  String? format(LogMessage event) => event.message.toString();
}
