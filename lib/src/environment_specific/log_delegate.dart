import 'package:meta/meta.dart';

import '../../l.dart';

@internal
// ignore: one_member_abstracts
abstract interface class LogDelegate {
  void log(LogMessage event);
}
