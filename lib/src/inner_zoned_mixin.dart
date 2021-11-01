import 'dart:async';

import 'package:meta/meta.dart';

import 'inner_logger.dart';
import 'log_level.dart';
import 'log_message.dart';
import 'log_options.dart';

const Symbol _kOptionsKey = #l.logOptions;

/// {@nodoc}
@internal
LogOptions? getCurrentLogOptions() {
  final Object? options = Zone.current[_kOptionsKey];
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
            ? <Symbol, LogOptions>{_kOptionsKey: logOptions}
            : null,
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) {
            if (logOptions?.handlePrint ?? true) {
              self.run(
                () => log(
                  LogMessage.create(
                    line,
                    const LogLevel.info(),
                  ),
                ),
              );
            } else {
              self.print(line);
            }
          },
        ),
      );
}
