import 'package:meta/meta.dart';

import '../log_level.dart';

/// {@nodoc}
@internal
// ignore: one_member_abstracts
abstract class LogDelegate {
  /// {@nodoc}
  void log({
    required Object message,
    required LogLevel logLevel,
    required StackTrace? stackTrace,
  });
}
