// ignore_for_file: public_member_api_docs, avoid_print
library l.example;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:l/l.dart';

void main() => runZonedGuarded<void>(
      () => l.capture<void>(
        () {
          l
            ..v('Regular 1')
            ..e('Error')
            ..w('Warning')
            ..i('Info')
            ..d('Debug')
            ..s('Shout')
            ..v6('Regular 6');
          print('Hello from original print!');
          runApp(const App());
          l.v('Running');
        },
        const LogOptions(
          handlePrint: true,
          messageFormatting: _messageFormatting,
        ),
      ),
      l.e,
    );

Object _messageFormatting(Object message, LogLevel logLevel, DateTime now) =>
    '${_timeFormat(now)} | $message';

String _timeFormat(DateTime time) =>
    '${time.hour}:${time.minute.toString().padLeft(2, '0')}';

@immutable
class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter [L]ogger example',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter [L]ogger example'),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      OutlinedButton(
                        onPressed: () => l.i(' * on click'),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Click me',
                            textScaleFactor: 2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      OutlinedButton(
                        onPressed: () => scheduleMicrotask(
                          () => throw UnsupportedError('Some UnsupportedError'),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Throw error',
                            textScaleFactor: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
