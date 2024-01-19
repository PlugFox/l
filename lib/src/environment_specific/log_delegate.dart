import 'package:meta/meta.dart';

import '../../l.dart';

/// {@nodoc}
@internal
// ignore: one_member_abstracts
abstract interface class LogDelegate {
  /// {@nodoc}
  void log(LogMessage event);
}
