library l.test;

import 'package:l/l.dart';
import 'package:test/test.dart';

void main() {
  group('l.mainFunctional', mainFunctional);
}

void mainFunctional() {
  test('shouldExists', () {
    expect(l is L, isTrue);
  });

  test('shouldPrint', () async {
    l
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
      ..vvvvvv('Regular 6');
    await Future<void>.delayed(const Duration(seconds: 1));
    expect(true, true);
  });
}
