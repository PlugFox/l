library l.test;

import 'package:l/l.dart';
import 'package:test/test.dart';

void main() => group('l.mainFunctional', mainFunctional);

void mainFunctional() {
  test(
    'shouldExists',
    () {
      // ignore: unnecessary_type_check
      expect(l is L, isTrue);
    },
  );

  test(
    'printColors',
    () {
      l.capture(
        () => l.i('Without color'),
        LogOptions(
          outputInRelease: true,
          printColors: false,
        ),
      );
      l.capture(
        () => l.i('With color'),
        LogOptions(
          outputInRelease: true,
          printColors: true,
        ),
      );
    },
  );

  test(
    'shouldPrint',
    () async {
      var count = 0;
      final sub = l.listen((_) => count++);

      l.capture(
        () {
          l
            ..s('01. Shout')
            ..v('02. Regular 1')
            ..e('03. Error')
            ..vv('04. Regular 2')
            ..w('05. Warning')
            ..vvv('06. Regular 3')
            ..i('07. Info')
            ..vvvv('08. Regular 4')
            ..d('09. Debug')
            ..vvvvv('10. Regular 5')
            ..vvvvvv('11. Regular 6');
          print('12. Handle print');
        },
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
      await Future<void>.delayed(Duration.zero);
      sub.cancel();
      expect(count, 12);
    },
  );
}
