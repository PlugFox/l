// ignore_for_file: public_member_api_docs, avoid_print
library l.example;

import 'dart:async';

import 'package:l/l.dart';

void main() => l.capture<void>(
      () => runZonedGuarded<void>(
        () {
          l
            ..v('Regular 1')
            ..e('Error')
            ..w('Warning')
            ..i('Info')
            ..d('Debug')
            ..s('Shout')
            ..v6('Regular 6');
          print('Hello from original print!');
          l.v('Running');
          throw Exception('Exception');
        },
        l.e,
      ),
      const LogOptions(
        handlePrint: true,
        messageFormatting: _messageFormatting,
        outputInRelease: false,
        printColors: true,
      ),
    );

Object _messageFormatting(Object message, LogLevel logLevel, DateTime now) =>
    '${_timeFormat(now)} | $message';

String _timeFormat(DateTime time) =>
    '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
