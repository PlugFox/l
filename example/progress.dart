// ignore_for_file: unnecessary_statements, avoid_print
import 'dart:async' show Stream, Future;

import 'package:l/l.dart';

void main() => _progress();

Future<void> _progress() async {
  await Future<void>.delayed(const Duration(milliseconds: 50));
  Stream<int>.fromIterable(List<int>.generate(101, (int v) => v))
      .asyncMap<int>((int v) =>
          Future<int>.delayed(const Duration(milliseconds: 25), () => v))
      .forEach((int v) => l.p(
          percent: v,
          header: '{{ HEADER #$v }}',
          footer: '{{ footer #$v }}',
          data: '{{ data $v% }}'))
        ..whenComplete(l.resume); // Must use 'resume'
  await Future<void>.delayed(const Duration(milliseconds: 25));
}
