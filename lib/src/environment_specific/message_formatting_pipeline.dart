import 'package:meta/meta.dart';

import '../log_message.dart';

@internal
abstract base class MessageFormattingPipeline {
  @internal
  String? format(LogMessage event) => event.message.toString();
}
