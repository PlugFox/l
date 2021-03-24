// ignore_for_file: unused_local_variable

library l.example.integration;

import 'package:l/l.dart';

void main() {
  l.forEach((logMessage) {
    final message = logMessage.message;
    final level = logMessage.level;
    final date = logMessage.date;
  });
}
