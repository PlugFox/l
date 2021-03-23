// ignore_for_file: avoid_print
library l.example.zoned;

import 'package:l/l.dart';

void main() => l.capture(
      someFunction,
      const LogOptions(
        handlePrint: false,
        messageFormatting: _messageFormatting,
      ),
    );

Future<void> someFunction() async {
  print('Hello');
  await Future<void>.delayed(const Duration(milliseconds: 150));
  l.d('world');
  await Future<void>.delayed(const Duration(milliseconds: 150));
  l.e('!!!');
}

Object _messageFormatting(Object message, LogLevel logLevel, DateTime now) =>
    '${now.hour}:${now.minute.toString().padLeft(2, '0')} $message';
