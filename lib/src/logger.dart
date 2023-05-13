import 'package:meta/meta.dart';

import 'log_message.dart';
import 'log_options.dart';

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
/// |     Method     | Description                          |
/// |----------------|--------------------------------------|
/// | [s]            | A shout is always displayed          |
/// | [v1], [v]      | Regular message with verbose level 1 |
/// | [e]            | Error message with verbose level 1   |
/// | [v2], [vv]     | Regular message with verbose level 2 |
/// | [w]            | Warning message with verbose level 2 |
/// | [v3], [vvv]    | Regular message with verbose level 3 |
/// | [i], [<]       | Inform message with verbose level 3  |
/// | [v4], [vvvv]   | Regular message with verbose level 4 |
/// | [d], [<<]      | Debug message with verbose level 4   |
/// | [v5], [vvvvv]  | Regular message with verbose level 5 |
/// | [v6], [vvvvvv] | Regular message with verbose level 6 |
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
@sealed
abstract interface class L implements Stream<LogMessage> {
  //L._();

  /// A shout [message] is always displayed
  void s(Object message);

  /// Regular [message] with verbose level 1
  void v(Object message);

  /// Regular [message] with verbose level 1
  void v1(Object message);

  /// Regular [message] with verbose level 2
  void vv(Object message);

  /// Regular [message] with verbose level 2
  void v2(Object message);

  /// Regular [message] with verbose level 3
  void vvv(Object message);

  /// Regular [message] with verbose level 3
  void v3(Object message);

  /// Regular [message] with verbose level 4
  void vvvv(Object message);

  /// Regular [message] with verbose level 4
  void v4(Object message);

  /// Regular [message] with verbose level 5
  void vvvvv(Object message);

  /// Regular [message] with verbose level 5
  void v5(Object message);

  /// Regular [message] with verbose level 6
  void vvvvvv(Object message);

  /// Regular [message] with verbose level 6
  void v6(Object message);

  /// Inform [message] with verbose level 3
  void i(Object message);

  /// Warning [message] with verbose level 2
  void w(Object message, [StackTrace? stackTrace]);

  /// Error [message] with verbose level 1
  void e(Object message, [StackTrace? stackTrace]);

  /// Debug [message] with verbose level 4
  void d(Object message);

  /// Set logger options for this zone
  /// The custom handler can intercept print operations and
  /// redirect them to [l.d] output
  ///
  /// ```dart
  ///   l.capture(
  ///     someFunction,
  ///     const LogOptions(
  ///       handlePrint: false,
  ///       messageFormatting: _messageFormatting,
  ///     ),
  ///   );
  /// ```
  ///
  @experimental
  R capture<R extends Object?>(R Function() body, [LogOptions? logOptions]);

  /// Add Inform [message] with verbose level 3
  void operator <(Object info);

  /// Add Debug [message] with verbose level 4
  void operator <<(Object debug);
}
