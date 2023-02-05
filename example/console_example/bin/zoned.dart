// ignore_for_file: avoid_print
library l.example.zoned;

import 'dart:async';

import 'package:l/l.dart';

void main() => l.capture<void>(
      () => runZonedGuarded<void>(
        someFunction,
        l.e,
      ),
      const LogOptions(
        handlePrint: true,
        useEmoji: true,
        messageFormatting: _messageFormatting,
      ),
    );

Future<void> someFunction() async {
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
