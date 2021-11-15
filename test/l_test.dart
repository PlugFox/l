library l.test;

import 'package:l/l.dart';
import 'package:test/test.dart';

void main() {
  group('l.mainFunctional', mainFunctional);
}

void mainFunctional() {
  test('shouldExists', () {
    // ignore: unnecessary_type_check
    expect(l is L, isTrue);
  });

  test('shouldPrint', () {
    l.capture(
      () => l
        ..s('Shout')
        ..v('Regular 1')
        ..e('Error')
        ..vv('Regular 2')
        ..w('Warning')
        ..vvv('Regular 3')
        ..i('Info')
        ..vvvv('Regular 4')
        ..d('Debug')
        ..vvvvv('Regular 5')
        ..vvvvvv('Regular 6'),
      LogOptions(
        outputInRelease: true,
        handlePrint: true,
        printColors: false,
        messageFormatting: (
          Object message,
          LogLevel logLevel,
          DateTime date,
        ) =>
            '${date.hour}:${date.minute.toString().padLeft(2, '0')} '
            '| $message',
      ),
    );
    expect(true, true);
  });
}
