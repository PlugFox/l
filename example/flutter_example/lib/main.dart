// ignore_for_file: public_member_api_docs, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:l/l.dart';

void main() => l.capture<void>(
      () => runZonedGuarded<void>(
        () async {
          l.d('runApp');
          print('original print');
          runApp(const App());
          l.v('Running');
        },
        l.e,
      ),
      const LogOptions(
        handlePrint: true,
        useEmoji: true,
      ),
    );

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
