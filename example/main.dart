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

  l.lvl = 4; // set verbose level
  l.store = true; // store logs
  l.s('shout me');
  l.e('error msg');
  l.w('warning msg');
  l.i('info msg');
  l < 'alt info msg';
  l.d('debug msg');
  l << 'alt debug msg';
  l.pause(); // pause log queue
  l.v('verbose lvl #1');
  l.vv('verbose lvl #2');
  l.vvv('verbose lvl #3');
  l.store = false; // store logs
  l.vvvv('verbose lvl #4');
  l.vvvvv('verbose lvl #5');
  l.vvvvvv('verbose lvl #6');
  l.resume(); // resume log queue
  l.clear(); // clear console
  ~l;
}
