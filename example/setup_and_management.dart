// ignore_for_file: unnecessary_statements, avoid_print
import 'package:l/l.dart';

void main() {
  l.lvl = 2; // set verbose level
  l.store = false; // don't store logs
  l.wide = true; // print l.vv as [    **]

  l.v('verbose lvl #1');
  l.pause(); // pause log queue
  l.vv('verbose lvl #2');
  l.vvv('verbose lvl #3');
  l.resume(); // resume log queue
  l.clear(); // clear console
}
