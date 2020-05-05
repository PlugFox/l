// ignore_for_file: unnecessary_statements, avoid_print
import 'dart:async' show Future;

import 'package:l/l.dart';

void main() => _displayStatuses()
    .whenComplete(_showProgressBar)
    .whenComplete(_displayDetails);

Future<void> _displayStatuses() async {
  l.store = true;
  l.s('shout me');
  l.e('error msg');
  l.w('warning msg');
  l.i('info msg');
  l < 'alt info msg';
  l.d('debug msg');
  l << 'alt debug msg';
}

Future<void> _showProgressBar() =>
    Stream<int>.fromIterable(List<int>.generate(101, (int v) => v))
        .asyncMap<int>((int v) =>
            Future<int>.delayed(const Duration(milliseconds: 50), () => v))
        .forEach((int v) => l.p(
            percent: v,
            header: '{{ HEADER #$v }}',
            footer: '{{ footer #$v }}',
            data: '{{ data $v% }}'))
          ..whenComplete(l.resume);

Future<void> _displayDetails() async {
  l.v('verbose lvl #1');
  l.vv('verbose lvl #2');
  l.vvv('verbose lvl #3');
  l.vvvv('verbose lvl #4');
  l.vvvvv('verbose lvl #5');
  l.vvvvvv('verbose lvl #6');
}
