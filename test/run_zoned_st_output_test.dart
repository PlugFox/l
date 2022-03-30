library run_zoned_st_output.test;

import 'dart:async';

import 'package:l/l.dart';
import 'package:test/test.dart';

void main() => group('l.runZonedOutput', runZonedOutput);

/// https://github.com/PlugFox/l/issues/20
void runZonedOutput() {
  test('Check Stack Overflow with print in runZoned', () async {
    l.capture<void>(
      () => runZoned<void>(
        () {
          print('sample');
        },
      ),
      LogOptions(
        outputInRelease: true,
        handlePrint: false,
      ),
    );
  });
  test('Check Stack Overflow with throw in runZonedGuarded', () async {
    l.capture<void>(
      () => runZonedGuarded<void>(
        () {
          throw Exception('sample');
        },
        (e, s) => print(e),
      ),
      LogOptions(
        outputInRelease: true,
        handlePrint: false,
      ),
    );
  });
}
