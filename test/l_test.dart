// ignore_for_file: unnecessary_statements, avoid_print, cascade_invocations
// ignore_for_file: non_const_call_to_literal_constructor, unnecessary_lambdas
// ignore_for_file: prefer_const_declarations, prefer_const_constructors
library l.test;

import 'dart:async';

import 'package:l/l.dart';
import 'package:l/src/environment_specific/log_delegate_stub.dart'
    as log_delegate_stub;
import 'package:l/src/environment_specific/log_delegate_vm.dart'
    as log_delegate_io;
import 'package:test/test.dart';

void main() {
  group('l.mainFunctional', mainFunctional);
  group('l.runZonedOutput', runZonedOutput);
  group('l.logLevel', logLevel);
  group('l.environmentSpecific', environmentSpecific);
  group('l.jsonSerialization', jsonSerialization);
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

  void printVerbose() {
    l
      ..v('v')
      ..vv('vv')
      ..vvv('vvv')
      ..vvvv('vvvv')
      ..vvvvv('vvvvv')
      ..vvvvvv('vvvvvv');
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
    'print verbose',
    () {
      printVerbose();
    },
  );

  test(
    'coloredOutput',
    () async {
      l.capture(
        printAllVariants,
        LogOptions(
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
        LogOptions(
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
    'create all log levels',
    () {
      expect(() => LogLevel.info(), returnsNormally);
      expect(() => LogLevel.warning(), returnsNormally);
      expect(() => LogLevel.debug(), returnsNormally);
      expect(() => LogLevel.shout(), returnsNormally);
      expect(() => LogLevel.info(), returnsNormally);
      expect(() => LogLevel.error(), returnsNormally);
      expect(() => LogLevel.v(), returnsNormally);
      expect(() => LogLevel.vv(), returnsNormally);
      expect(() => LogLevel.vvv(), returnsNormally);
      expect(() => LogLevel.vvvv(), returnsNormally);
      expect(() => LogLevel.vvvvv(), returnsNormally);
      expect(() => LogLevel.vvvvvv(), returnsNormally);
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
      expect(
        () => log_delegate_stub.createEnvironmentLogDelegate(),
        returnsNormally,
      );
      final delegate = log_delegate_stub.createEnvironmentLogDelegate();
      delegate.log(
        message: 'Message with LogDelegateStub',
        logLevel: const LogLevel.debug(),
        date: DateTime.now(),
      );
      expect(() => delegate.toString(), returnsNormally);
    },
  );

  test(
    'LogDelegateIO',
    () {
      expect(
        () => log_delegate_io.createEnvironmentLogDelegate(),
        returnsNormally,
      );
      final delegate = log_delegate_io.createEnvironmentLogDelegate();
      delegate.log(
        message: 'Message with LogDelegateIO',
        logLevel: const LogLevel.debug(),
        date: DateTime.now(),
      );
      expect(() => delegate.toString(), returnsNormally);
    },
    onPlatform: {
      'browser': Skip('Not supported on Browser'),
    },
  );
}

void jsonSerialization() {
  final date = DateTime.now();
  final message = 'Test message';
  final level = LogLevel.info();
  final stackTrace = StackTrace.current;

  test('should correctly serialize to JSON', () {
    final logMessage = LogMessage(
      message: message,
      level: level,
      date: date,
    );
    expect(
      logMessage.toJson(),
      equals({
        'date': date.microsecondsSinceEpoch,
        'message': message,
        'level': level.prefix,
      }),
    );
  });

  test('should correctly deserialize from JSON', () {
    final json = {
      'date': date.microsecondsSinceEpoch,
      'message': message,
      'level': level.prefix,
    };
    final logMessage = LogMessage.fromJson(json);

    expect(logMessage, isA<LogMessage>());
    expect(logMessage.date, equals(date));
    expect(logMessage.message, equals(message));
    expect(logMessage.level, equals(level));
  });

  test('should correctly serialize to JSON with StackTrace', () {
    final logMessage = LogMessage.stackTrace(
      message: message,
      level: level,
      date: date,
      stackTrace: stackTrace,
    );
    expect(
      logMessage.toJson(),
      equals({
        'date': date.microsecondsSinceEpoch,
        'message': message,
        'level': level.prefix,
        'stack_trace': stackTrace.toString(),
      }),
    );
  });

  test('should correctly deserialize from JSON with StackTrace', () {
    final json = {
      'date': date.microsecondsSinceEpoch,
      'message': message,
      'level': level.prefix,
      'stack_trace': stackTrace.toString(),
    };
    final logMessage = LogMessage.fromJson(json);

    expect(
      logMessage,
      isA<LogMessageWithStackTrace>().having(
        (l) => l.stackTrace.toString(),
        'stackTrace',
        equals(stackTrace.toString()),
      ),
    );
    expect(logMessage.date, equals(date));
    expect(logMessage.message, equals(message));
    expect(logMessage.level, equals(level));
  });
}
