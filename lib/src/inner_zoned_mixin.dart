import 'dart:async';

import 'package:meta/meta.dart';

import 'inner_logger.dart';
import 'log_level.dart';
import 'log_message.dart';
import 'log_options.dart';

const Symbol _kOptionsKey = #l.logOptions;

/// Receive [LogOptions] from [Zone]
@internal
LogOptions? getCurrentLogOptions() => switch (Zone.current[_kOptionsKey]) {
      final LogOptions options => options,
      _ => null,
    };

/// Internal mixin for [InnerLogger] to run in [Zone]
@internal
base mixin InnerZonedMixin on InnerLogger {
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
              self.run<void>(
                () => log(LogMessage.create(line, const LogLevel.info())),
              );
            } else {
              // Replace [self] with [parent] zone
              // https://github.com/PlugFox/l/issues/20
              //self.print(line);
              parent.print(zone, line);
            }
          },
        ),
      );
}
