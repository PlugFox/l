// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:l/l.dart';

void main() {
  l.d('runApp');
  runApp(const App());
  l.v('Running');
}

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
              child: OutlinedButton(
                onPressed: () {
                  l.i(' * on click');
                },
                child: const Text('Click me'),
              ),
            ),
          ),
        ),
      );
}
