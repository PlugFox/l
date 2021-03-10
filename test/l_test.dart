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
      ..v('Regular 1')
      ..e('Error')
      ..w('Warning')
      ..i('Info')
      ..d('Debug')
      ..s('Shout')
      ..vvvvvv('Regular 6');
    await Future<void>.delayed(const Duration(seconds: 1));
    expect(true, true);
  });
}
