import 'package:meta/meta.dart';

import '../inner_zoned_mixin.dart';
import '../log_level.dart';

/// {@nodoc}
@internal
Object messageLogFormatter({
  required Object message,
  required LogLevel logLevel,
}) =>
    getCurrentLogOptions()?.messageFormatting?.call(
          message,
          logLevel,
          DateTime.now(),
        ) ??
    message;
