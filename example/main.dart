// ignore_for_file: public_member_api_docs, avoid_print
// ignore_for_file: use_named_constants, do_not_use_environment

library l.example;

import 'dart:async';
import 'dart:convert';

import 'package:l/l.dart';

/// Whether to override the output of the logger.
const bool overrideOutput = true;

void main([List<String>? args]) => l.capture<void>(
      () => runZonedGuarded<void>(
        () {
          l
            ..v('Regular 1')
            ..e('Error')
            ..w('Warning')
            ..i('Info')
            ..d('Debug')
            ..s('Shout')
            ..vv('Regular 2')
            ..v6('Regular 6');
          print('Hello from original print!');
          l.v('Running');
          throw Exception('Exception');
        },
        l.e, // Log uncaught errors received by the zone.
      ),
      // Logger options passed to the underlying logger zone.
      const LogOptions(
        handlePrint: true, // Whether to handle `print()` calls.
        messageFormatting: _customFormatter,
        overrideOutput: overrideOutput ? _customPrinter : null,
        outputInRelease: false, // Whether to output in release mode.
        printColors: true, // Whether to print colors in the console.
      ),
    );

/// Format messages and truncate them to 25 characters long.
Object _customFormatter(LogMessage event) => switch (event.message.toString()) {
      final String msg when msg.length > 25 =>
        '${msg.substring(0, 25 - 4)} ...',
      final String msg => msg,
    };

/// Also, we can output messages to a file, or to a database, or to a server.
String? _customPrinter(LogMessage event) => jsonEncode(<String, Object?>{
      'timestamp': event.timestamp.toUtc().toIso8601String(),
      'level': event.level.toString(),
      'message': event.message.toString(),
    });
