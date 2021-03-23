import 'dart:async';

import 'inner_logger.dart';
import 'log_level.dart';

///
mixin InnerPrintHandlerMixin on InnerLogger {
  @override
  R printHandler<R extends Object?>(R Function() body) =>
      runZoned<R>(body, zoneSpecification: ZoneSpecification(
        print: (self, parent, zone, line) {
          log(message: line, logLevel: const LogLevel.info());
        },
      ));
}
