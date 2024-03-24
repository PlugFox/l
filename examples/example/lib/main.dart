// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:l/l.dart';

Future<void> main() async {
  l.capture<void>(
    () => runZonedGuarded<void>(
      () {
        runApp(
          MaterialApp(
            scrollBehavior: const MaterialScrollBehavior()
                .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
            home: const Demo(),
          ),
        );
      },
      l.e, // Log uncaught errors received by the zone.
    ),
    // Logger options passed to the underlying logger zone.
    // ignore: prefer_const_constructors
    LogOptions(
      handlePrint: false, // Whether to handle `print()` calls.
      overrideOutput: _customPrinter,
      outputInRelease: false, // Whether to output in release mode.
      printColors: true, // Whether to print colors in the console.
    ),
  );
}

/// Also, we can output messages to a file, or to a database, or to a server.
String? _customPrinter(LogMessage event, String? consoleMessage) {
  log(consoleMessage ?? '');
  return null;
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  Future<void> test() async {
    l
      ..v('Regular 1')
      ..e('Error')
      ..w('Warning')
      ..i('Info')
      ..d('Debug')
      ..s('Shout')
      ..vv('Regular 2')
      ..v6('Regular 6');
    print('Hello from original print!');
    l.v('Running');
    throw Exception('Exception');
  }

  void veryLongMessage(void Function(String msg) printer) {
    printer('Very long message ' * 1000 + 'end');
    print('---');
    print('---');
    print('---');
    printer('Very long message\n' * 1000 + 'end');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: test,
                      child: const Text('test'),
                    ),
                    TextButton(
                      onPressed: () => veryLongMessage(print),
                      child: const Text('veryLongMessage(print)'),
                    ),
                    TextButton(
                      onPressed: () => veryLongMessage(debugPrint),
                      child: const Text('veryLongMessage(debugPrint)'),
                    ),
                    TextButton(
                      onPressed: () => veryLongMessage(log),
                      child: const Text('veryLongMessage(log)'),
                    ),
                    TextButton(
                      onPressed: () => veryLongMessage(l.i),
                      child: const Text('veryLongMessage(l.i)'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
