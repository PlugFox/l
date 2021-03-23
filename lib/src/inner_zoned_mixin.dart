import 'dart:async';

import 'package:meta/meta.dart';

import 'inner_logger.dart';
import 'log_level.dart';
import 'log_options.dart';

/// {@nodoc}
@internal
const Symbol kOptionsKey = #l.logOptions;

/// {@nodoc}
@internal
LogOptions? getCurrentLogOptions() {
  final Object? options = Zone.current[kOptionsKey];
  if (options is LogOptions) {
    return options;
  }
  return null;
}

/// {@nodoc}
mixin InnerZonedMixin on InnerLogger {
  @override
  R capture<R extends Object?>(R Function() body, [LogOptions? logOptions]) =>
      runZoned<R>(
        body,
        zoneValues: logOptions != null
            ? <Symbol, LogOptions>{kOptionsKey: logOptions}
            : null,
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) {
            if (logOptions?.handlePrint ?? true) {
              log(message: line, logLevel: const LogLevel.info());
            } else {
              parent.print(zone, line);
            }
          },
        ),
      );
}
