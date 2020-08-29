library test.l;

import 'package:l/l.dart';
import 'package:test/test.dart';

void main() {
  group('l.mainFunctional', mainFunctional);
}

void mainFunctional() {
  test('shouldExists', () {
    expect(l != null, isTrue);
    expect(L.instance != null, isTrue);
    expect(L.I != null, isTrue);
  });
}
