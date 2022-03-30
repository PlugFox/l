// ignore_for_file: unnecessary_statements, avoid_print, cascade_invocations
// ignore_for_file: non_const_call_to_literal_constructor, unnecessary_lambdas
// ignore_for_file: prefer_const_declarations
library l.test;

import 'dart:async';

import 'package:l/l.dart';
import 'package:l/src/environment_specific/log_delegate_stub.dart'
    as log_delegate_stub;
import 'package:test/test.dart';

void main() {
  group('l.mainFunctional', mainFunctional);
  group('l.runZonedOutput', runZonedOutput);
  group('l.logLevel', logLevel);
  group('l.environmentSpecific', environmentSpecific);
}

void mainFunctional() {
  void printAllVariants() {
    l
      ..s('01. Shout')
      ..v1('02. Regular 1')
      ..e('03. Error')
      ..v2('04. Regular 2')
      ..w('05. Warning')
      ..v3('06. Regular 3')
      ..i('07. Info')
      ..v4('08. Regular 4')
      ..d('09. Debug')
      ..v5('10. Regular 5')
      ..v6('11. Regular 6');
    print('12. Handle print');
  }

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
        const LogOptions(
          outputInRelease: true,
          printColors: false,
        ),
      );
      l.capture(
        () => l.i('With color'),
        const LogOptions(
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
        printAllVariants,
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
      await sub.cancel();
      expect(count, 12);
    },
  );

  test(
    'coloredOutput',
    () async {
      l.capture(
        printAllVariants,
        const LogOptions(
          outputInRelease: true,
          handlePrint: false,
          printColors: true,
        ),
      );
      await Future<void>.delayed(Duration.zero);
    },
  );

  test(
    'logWithArrow',
    () {
      l.capture(
        () {
          l < 'info with arrow';
          l << 'debug with arrow';
        },
        const LogOptions(
          outputInRelease: true,
        ),
      );
    },
  );

  test(
    'logWithStackTrace',
    () {
      l.w('warning with stackTrace', StackTrace.empty);
      l.e('error with stackTrace', StackTrace.current);
    },
  );
}

/// https://github.com/PlugFox/l/issues/20
void runZonedOutput() {
  test('Check Stack Overflow with print in runZoned', () async {
    l.capture<void>(
      () => runZoned<void>(
        () {
          print('sample');
        },
      ),
      const LogOptions(
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
      const LogOptions(
        outputInRelease: true,
        handlePrint: false,
      ),
    );
  });
}

void logLevel() {
  test(
    'maybeWhen',
    () {
      expect(
        LogLevel.v().maybeWhen(orElse: () => false, v: () => true),
        isTrue,
      );
      expect(
        LogLevel.vv().maybeWhen(orElse: () => false, vv: () => true),
        isTrue,
      );
      expect(
        LogLevel.vvv().maybeWhen(orElse: () => false, vvv: () => true),
        isTrue,
      );
      expect(
        LogLevel.vvvv().maybeWhen(orElse: () => false, vvvv: () => true),
        isTrue,
      );
      expect(
        LogLevel.vvvvv().maybeWhen(orElse: () => false, vvvvv: () => true),
        isTrue,
      );
      expect(
        LogLevel.vvvvvv().maybeWhen(orElse: () => false, vvvvvv: () => true),
        isTrue,
      );
      expect(
        LogLevel.debug().maybeWhen(orElse: () => false, debug: () => true),
        isTrue,
      );
      expect(
        LogLevel.error().maybeWhen(orElse: () => false, error: () => true),
        isTrue,
      );
      expect(
        LogLevel.info().maybeWhen(orElse: () => false, info: () => true),
        isTrue,
      );
      expect(
        LogLevel.warning().maybeWhen(orElse: () => false, warning: () => true),
        isTrue,
      );
      expect(
        LogLevel.shout().maybeWhen(orElse: () => false, shout: () => true),
        isTrue,
      );
      expect(
        LogLevel.info().maybeWhen(orElse: () => true, debug: () => false),
        isTrue,
      );
    },
  );

  test(
    'levels',
    () {
      final levels = LogLevel.values;
      for (final level in levels) {
        expect(() => level.toString(), returnsNormally);
        expect(() => level.hashCode, returnsNormally);
        expect(LogLevel.values, contains(level));
      }
      expect(LogLevel.info(), LogLevel.info());
    },
  );

  test(
    'with stack trace',
    () {
      const obj = 'message';
      final st = StackTrace.current;
      const level = LogLevel.debug();
      final msg = LogMessageWithStackTrace.create(
        obj,
        level,
        st,
      );
      expect(msg.message, obj);
      expect(msg.level, level);
      expect(msg.stackTrace, st);
      expect(() => msg.toString(), returnsNormally);
      expect(() => msg.toJson(), returnsNormally);
      expect(msg.toJson(), isA<Map<String, Object?>>());
    },
  );
}

void environmentSpecific() {
  test(
    'LogDelegateStub',
    () {
      final delegate = log_delegate_stub.createEnvironmentLogDelegate();
      delegate.log(
        message: 'Message with LogDelegateStub',
        logLevel: const LogLevel.debug(),
      );
      expect(() => delegate.toString(), returnsNormally);
    },
  );
}
