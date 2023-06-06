import 'package:meta/meta.dart';

/// Verbose levels
@immutable
sealed class LogLevel {
  /// A shout is always displayed
  @literal
  const factory LogLevel.shout() = _LogLevelShout;

  /// Regular message with verbose level 1
  @literal
  const factory LogLevel.v() = _LogLevelRegular1;

  /// Error message with verbose level 1
  @literal
  const factory LogLevel.error() = _LogLevelError;

  /// Regular message with verbose level 2
  @literal
  const factory LogLevel.vv() = _LogLevelRegular2;

  /// Warning message with verbose level 2
  @literal
  const factory LogLevel.warning() = _LogLevelWarning;

  /// Regular message with verbose level 3
  @literal
  const factory LogLevel.vvv() = _LogLevelRegular3;

  /// Inform message with verbose level 3
  @literal
  const factory LogLevel.info() = _LogLevelInfo;

  /// Regular message with verbose level 4
  @literal
  const factory LogLevel.vvvv() = _LogLevelRegular4;

  /// Debug message with verbose level 4
  @literal
  const factory LogLevel.debug() = _LogLevelDebug;

  /// Regular message with verbose level 5
  @literal
  const factory LogLevel.vvvvv() = _LogLevelRegular5;

  /// Regular message with verbose level 6
  @literal
  const factory LogLevel.vvvvvv() = _LogLevelRegular6;

  /// {@nodoc}
  const LogLevel._({
    required this.prefix,
    required this.level,
  });

  /// Restore log level from [value].
  /// If [value] is not found, then [LogLevel.info] is returned.
  factory LogLevel.fromValue(Object? value) =>
      _table[value] ?? const LogLevel.info();

  /// {@nodoc}
  static final Map<Object, LogLevel> _table = Map<Object, LogLevel>.fromEntries(
    values.expand<MapEntry<Object, LogLevel>>((e) sync* {
      yield MapEntry<Object, LogLevel>(e.level, e);
      yield MapEntry<Object, LogLevel>(e.prefix, e);
    }),
  );

  /// As prefix
  final String prefix;

  /// Integer level representation
  final int level;

  /// [when] defines a conditional expression with multiple branches.
  /// It is similar to the switch statement in C-like languages.
  ///
  /// [when] matches its argument against all branches sequentially
  /// until some branch condition is satisfied.
  ///
  LogLevelResult when<LogLevelResult>({
    required LogLevelResult Function() shout,
    required LogLevelResult Function() v,
    required LogLevelResult Function() error,
    required LogLevelResult Function() vv,
    required LogLevelResult Function() warning,
    required LogLevelResult Function() vvv,
    required LogLevelResult Function() info,
    required LogLevelResult Function() vvvv,
    required LogLevelResult Function() debug,
    required LogLevelResult Function() vvvvv,
    required LogLevelResult Function() vvvvvv,
  });

  /// The [maybeWhen] method is equivalent to [when],
  /// but doesn't require all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra [orElse] required parameter,
  /// for fallback behavior.
  ///
  LogLevelResult maybeWhen<LogLevelResult>({
    required LogLevelResult Function() orElse,
    LogLevelResult Function()? shout,
    LogLevelResult Function()? v,
    LogLevelResult Function()? error,
    LogLevelResult Function()? vv,
    LogLevelResult Function()? warning,
    LogLevelResult Function()? vvv,
    LogLevelResult Function()? info,
    LogLevelResult Function()? vvvv,
    LogLevelResult Function()? debug,
    LogLevelResult Function()? vvvvv,
    LogLevelResult Function()? vvvvvv,
  }) =>
      when(
        shout: shout ?? orElse,
        v: v ?? orElse,
        error: error ?? orElse,
        vv: vv ?? orElse,
        warning: warning ?? orElse,
        vvv: vvv ?? orElse,
        info: info ?? orElse,
        vvvv: vvvv ?? orElse,
        debug: debug ?? orElse,
        vvvvv: vvvvv ?? orElse,
        vvvvvv: vvvvvv ?? orElse,
      );

  /// List of available verbose levels
  static const List<LogLevel> values = <LogLevel>[
    LogLevel.shout(),
    LogLevel.v(),
    LogLevel.error(),
    LogLevel.vv(),
    LogLevel.warning(),
    LogLevel.vvv(),
    LogLevel.info(),
    LogLevel.vvvv(),
    LogLevel.debug(),
    LogLevel.vvvvv(),
    LogLevel.vvvvvv(),
  ];

  @override
  String toString() => prefix;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is LogLevel && level == other.level);

  @override
  int get hashCode => level;
}

final class _LogLevelShout extends LogLevel {
  const _LogLevelShout()
      : super._(
          prefix: '!',
          level: 0,
        );

  @override
  LogLevelResult when<LogLevelResult>({
    required LogLevelResult Function() shout,
    required LogLevelResult Function() v,
    required LogLevelResult Function() error,
    required LogLevelResult Function() vv,
    required LogLevelResult Function() warning,
    required LogLevelResult Function() vvv,
    required LogLevelResult Function() info,
    required LogLevelResult Function() vvvv,
    required LogLevelResult Function() debug,
    required LogLevelResult Function() vvvvv,
    required LogLevelResult Function() vvvvvv,
  }) =>
      shout();
}

final class _LogLevelRegular1 extends LogLevel {
  const _LogLevelRegular1()
      : super._(
          prefix: '1',
          level: 1,
        );

  @override
  LogLevelResult when<LogLevelResult>({
    required LogLevelResult Function() shout,
    required LogLevelResult Function() v,
    required LogLevelResult Function() error,
    required LogLevelResult Function() vv,
    required LogLevelResult Function() warning,
    required LogLevelResult Function() vvv,
    required LogLevelResult Function() info,
    required LogLevelResult Function() vvvv,
    required LogLevelResult Function() debug,
    required LogLevelResult Function() vvvvv,
    required LogLevelResult Function() vvvvvv,
  }) =>
      v();
}

final class _LogLevelError extends LogLevel {
  const _LogLevelError()
      : super._(
          prefix: 'E',
          level: 1,
        );

  @override
  LogLevelResult when<LogLevelResult>({
    required LogLevelResult Function() shout,
    required LogLevelResult Function() v,
    required LogLevelResult Function() error,
    required LogLevelResult Function() vv,
    required LogLevelResult Function() warning,
    required LogLevelResult Function() vvv,
    required LogLevelResult Function() info,
    required LogLevelResult Function() vvvv,
    required LogLevelResult Function() debug,
    required LogLevelResult Function() vvvvv,
    required LogLevelResult Function() vvvvvv,
  }) =>
      error();
}

final class _LogLevelRegular2 extends LogLevel {
  const _LogLevelRegular2()
      : super._(
          prefix: '2',
          level: 2,
        );

  @override
  LogLevelResult when<LogLevelResult>({
    required LogLevelResult Function() shout,
    required LogLevelResult Function() v,
    required LogLevelResult Function() error,
    required LogLevelResult Function() vv,
    required LogLevelResult Function() warning,
    required LogLevelResult Function() vvv,
    required LogLevelResult Function() info,
    required LogLevelResult Function() vvvv,
    required LogLevelResult Function() debug,
    required LogLevelResult Function() vvvvv,
    required LogLevelResult Function() vvvvvv,
  }) =>
      vv();
}

final class _LogLevelWarning extends LogLevel {
  const _LogLevelWarning()
      : super._(
          prefix: 'W',
          level: 2,
        );

  @override
  LogLevelResult when<LogLevelResult>({
    required LogLevelResult Function() shout,
    required LogLevelResult Function() v,
    required LogLevelResult Function() error,
    required LogLevelResult Function() vv,
    required LogLevelResult Function() warning,
    required LogLevelResult Function() vvv,
    required LogLevelResult Function() info,
    required LogLevelResult Function() vvvv,
    required LogLevelResult Function() debug,
    required LogLevelResult Function() vvvvv,
    required LogLevelResult Function() vvvvvv,
  }) =>
      warning();
}

final class _LogLevelRegular3 extends LogLevel {
  const _LogLevelRegular3()
      : super._(
          prefix: '3',
          level: 3,
        );

  @override
  LogLevelResult when<LogLevelResult>({
    required LogLevelResult Function() shout,
    required LogLevelResult Function() v,
    required LogLevelResult Function() error,
    required LogLevelResult Function() vv,
    required LogLevelResult Function() warning,
    required LogLevelResult Function() vvv,
    required LogLevelResult Function() info,
    required LogLevelResult Function() vvvv,
    required LogLevelResult Function() debug,
    required LogLevelResult Function() vvvvv,
    required LogLevelResult Function() vvvvvv,
  }) =>
      vvv();
}

final class _LogLevelInfo extends LogLevel {
  const _LogLevelInfo()
      : super._(
          prefix: 'I',
          level: 3,
        );

  @override
  LogLevelResult when<LogLevelResult>({
    required LogLevelResult Function() shout,
    required LogLevelResult Function() v,
    required LogLevelResult Function() error,
    required LogLevelResult Function() vv,
    required LogLevelResult Function() warning,
    required LogLevelResult Function() vvv,
    required LogLevelResult Function() info,
    required LogLevelResult Function() vvvv,
    required LogLevelResult Function() debug,
    required LogLevelResult Function() vvvvv,
    required LogLevelResult Function() vvvvvv,
  }) =>
      info();
}

final class _LogLevelRegular4 extends LogLevel {
  const _LogLevelRegular4()
      : super._(
          prefix: '4',
          level: 4,
        );

  @override
  LogLevelResult when<LogLevelResult>({
    required LogLevelResult Function() shout,
    required LogLevelResult Function() v,
    required LogLevelResult Function() error,
    required LogLevelResult Function() vv,
    required LogLevelResult Function() warning,
    required LogLevelResult Function() vvv,
    required LogLevelResult Function() info,
    required LogLevelResult Function() vvvv,
    required LogLevelResult Function() debug,
    required LogLevelResult Function() vvvvv,
    required LogLevelResult Function() vvvvvv,
  }) =>
      vvvv();
}

final class _LogLevelDebug extends LogLevel {
  const _LogLevelDebug()
      : super._(
          prefix: 'D',
          level: 4,
        );

  @override
  LogLevelResult when<LogLevelResult>({
    required LogLevelResult Function() shout,
    required LogLevelResult Function() v,
    required LogLevelResult Function() error,
    required LogLevelResult Function() vv,
    required LogLevelResult Function() warning,
    required LogLevelResult Function() vvv,
    required LogLevelResult Function() info,
    required LogLevelResult Function() vvvv,
    required LogLevelResult Function() debug,
    required LogLevelResult Function() vvvvv,
    required LogLevelResult Function() vvvvvv,
  }) =>
      debug();
}

final class _LogLevelRegular5 extends LogLevel {
  const _LogLevelRegular5()
      : super._(
          prefix: '5',
          level: 5,
        );

  @override
  LogLevelResult when<LogLevelResult>({
    required LogLevelResult Function() shout,
    required LogLevelResult Function() v,
    required LogLevelResult Function() error,
    required LogLevelResult Function() vv,
    required LogLevelResult Function() warning,
    required LogLevelResult Function() vvv,
    required LogLevelResult Function() info,
    required LogLevelResult Function() vvvv,
    required LogLevelResult Function() debug,
    required LogLevelResult Function() vvvvv,
    required LogLevelResult Function() vvvvvv,
  }) =>
      vvvvv();
}

final class _LogLevelRegular6 extends LogLevel {
  const _LogLevelRegular6()
      : super._(
          prefix: '6',
          level: 6,
        );

  @override
  LogLevelResult when<LogLevelResult>({
    required LogLevelResult Function() shout,
    required LogLevelResult Function() v,
    required LogLevelResult Function() error,
    required LogLevelResult Function() vv,
    required LogLevelResult Function() warning,
    required LogLevelResult Function() vvv,
    required LogLevelResult Function() info,
    required LogLevelResult Function() vvvv,
    required LogLevelResult Function() debug,
    required LogLevelResult Function() vvvvv,
    required LogLevelResult Function() vvvvvv,
  }) =>
      vvvvvv();
}
