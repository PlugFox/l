// ignore_for_file: unnecessary_statements, avoid_print
import 'package:l/l.dart';

void main() {
  // Broadcast stream instantly receiving logs.
  l.stream.forEach((LogMessage log) => print('* ${log.level}'));

  // Middleware queue, functions are called
  // at the time of log processing
  l.mw.addAll(<Future<void> Function(LogMessage)>[
    (LogMessage log) async {
      print('# ${log.date}');
    },
    (LogMessage log) async {
      print('# ${log.message}');
    },
  ]);

  l < 'info msg';
  l << 'debug msg';
}
