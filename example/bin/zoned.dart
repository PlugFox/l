// ignore_for_file: avoid_print
library l.example;

import 'dart:async';

import 'package:l/l.dart';

final List<LogMessage> $logs = <LogMessage>[];
void main() => l.capture<void>(
      () => runZonedGuarded<void>(
        () {
          l.forEach($logs.add);
          runApp();
        },
        l.e,
      ),
      const LogOptions(
        handlePrint: true,
        useEmoji: true,
        outputInRelease: true,
        printColors: false,
        printStackTrace: true,
        messageFormatting: _messageFormatting,
        stackTraceFormatting: null,
      ),
    );

Future<void> runApp() async {
  l
    ..v('Regular 1')
    ..e('Error', StackTrace.current)
    ..w('Warning')
    ..i('Info')
    ..d('Debug')
    ..s('Shout')
    ..v6('Regular 6');
  print('Hello from original print!');
  throw UnsupportedError('Some error');
}

String _messageFormatting(Object message, LogLevel logLevel, DateTime now) =>
    '${_timeFormat(now)} | $message';

String _timeFormat(DateTime time) =>
    '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
