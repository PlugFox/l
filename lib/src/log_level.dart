import 'package:meta/meta.dart';

/// Verbose levels
@immutable
abstract class LogLevel {
  /// As prefix
  final String prefix;

  /// Integer level representation
  final int level;

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

  /// TODO: when implementation

  @override
  String toString() => prefix;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is LogLevel && level == other.level);

  @override
  int get hashCode => level;
}

class _LogLevelShout extends LogLevel {
  const _LogLevelShout()
      : super._(
          prefix: '!',
          level: 0,
        );
}

class _LogLevelRegular1 extends LogLevel {
  const _LogLevelRegular1()
      : super._(
          prefix: '1',
          level: 1,
        );
}

class _LogLevelError extends LogLevel {
  const _LogLevelError()
      : super._(
          prefix: 'E',
          level: 1,
        );
}

class _LogLevelRegular2 extends LogLevel {
  const _LogLevelRegular2()
      : super._(
          prefix: '2',
          level: 2,
        );
}

class _LogLevelWarning extends LogLevel {
  const _LogLevelWarning()
      : super._(
          prefix: 'W',
          level: 2,
        );
}

class _LogLevelRegular3 extends LogLevel {
  const _LogLevelRegular3()
      : super._(
          prefix: '3',
          level: 3,
        );
}

class _LogLevelInfo extends LogLevel {
  const _LogLevelInfo()
      : super._(
          prefix: 'I',
          level: 3,
        );
}

class _LogLevelRegular4 extends LogLevel {
  const _LogLevelRegular4()
      : super._(
          prefix: '4',
          level: 4,
        );
}

class _LogLevelDebug extends LogLevel {
  const _LogLevelDebug()
      : super._(
          prefix: 'D',
          level: 4,
        );
}

class _LogLevelRegular5 extends LogLevel {
  const _LogLevelRegular5()
      : super._(
          prefix: '5',
          level: 5,
        );
}

class _LogLevelRegular6 extends LogLevel {
  const _LogLevelRegular6()
      : super._(
          prefix: '6',
          level: 6,
        );
}
