// ignore_for_file: avoid_print
library l.example.zoned;

import 'package:l/l.dart';

void main() => l.printHandler(someFunction);

Future<void> someFunction() async {
  print('Hello');
  await Future<void>.delayed(const Duration(milliseconds: 150));
  print('world');
  await Future<void>.delayed(const Duration(milliseconds: 150));
  print('!!!');
}
