import '../log_level.dart';

/// {@nodoc}
// ignore: one_member_abstracts
abstract class LogDelegate {
  /// {@nodoc}
  void log({
    required Object message,
    required LogLevel logLevel,
  });
}
