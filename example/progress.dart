// ignore_for_file: unnecessary_statements, avoid_print, cascade_invocations
import 'dart:async' show Stream, Future;

import 'package:l/l.dart';

void main() => _progress();

Future<void> _progress() async {
  await Future<void>.delayed(const Duration(milliseconds: 50));
  // ignore: unawaited_futures
  Stream<int>.fromIterable(List<int>.generate(101, (v) => v))
      .asyncMap<int>(
          (v) => Future<int>.delayed(const Duration(milliseconds: 25), () => v))
      .forEach((v) => l.p(
          percent: v,
          header: '{{ HEADER #$v }}',
          footer: '{{ footer #$v }}',
          data: '{{ data $v% }}'))
      .whenComplete(l.resume); // Must use 'resume'
  await Future<void>.delayed(const Duration(milliseconds: 25));
}
