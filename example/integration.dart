library l.example.integration;

import 'package:l/l.dart';

void main() {
  l.forEach((logMessage) {
    final message = logMessage.message;
    final level = logMessage.level;
    final date = logMessage.date;
  });
}
