import 'package:meta/meta.dart';

import 'log_message.dart';

/// [L]ogger
///
/// Cross-platform html/io Logger with simple API.
/// No need to create an object. Just import and use.
/// Simple and w/o boilerplate.
/// Work with native console.
///
/// When there is no direct access to the terminal,
/// it works through print.
///
/// ### Key features
///
/// | Method   | Description                          |
/// |----------|--------------------------------------|
/// | [s]      | A shout is always displayed          |
/// | [v]      | Regular message with verbose level 1 |
/// | [e]      | Error message with verbose level 1   |
/// | [vv]     | Regular message with verbose level 2 |
/// | [w]      | Warning message with verbose level 2 |
/// | [vvv]    | Regular message with verbose level 3 |
/// | [i]      | Inform message with verbose level 3  |
/// | [vvvv]   | Regular message with verbose level 4 |
/// | [d]      | Debug message with verbose level 4   |
/// | [vvvvv]  | Regular message with verbose level 5 |
/// | [vvvvvv] | Regular message with verbose level 6 |
///
///
/// ### Integration capabilities
///
/// | Method      | Description                       |
/// |-------------|-----------------------------------|
/// | [listen]    | Broadcast stream receiving logs.  |
///
/// **!!! PLEASE, DO NOT LOG SENSITIVE INFORMATION !!!**
///
@immutable
abstract class L extends Stream<LogMessage> {
  L._();

  /// A shout is always displayed
  void s(Object message);

  /// Regular message with verbose level 1
  void v(Object message);

  /// Regular message with verbose level 2
  void vv(Object message);

  /// Regular message with verbose level 3
  void vvv(Object message);

  /// Regular message with verbose level 4
  void vvvv(Object message);

  /// Regular message with verbose level 5
  void vvvvv(Object message);

  /// Regular message with verbose level 6
  void vvvvvv(Object message);

  /// Inform message with verbose level 3
  void i(Object message);

  /// Warning message with verbose level 2
  void w(Object message);

  /// Error message with verbose level 1
  void e(Object message);

  /// Debug message with verbose level 4
  void d(Object message);

  /// Add Inform message with verbose level 3
  void operator <(Object info);

  /// Add Debug message with verbose level 4
  void operator <<(Object debug);
}
