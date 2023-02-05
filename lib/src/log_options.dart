import 'package:meta/meta.dart';

import 'log_level.dart';

/// Output message formatting
/// Expected to return a [String] or [Null]
typedef MessageFormatting = Object? Function(
  Object message,
  LogLevel logLevel,
  DateTime dateTime,
);

/// Output StackTrace formatting
/// Expected to return a [String] or [StackTrace] or [Null]
typedef StackTraceFormatting = Object? Function(
  StackTrace stackTrace,
);

/// Logger options
/// Used to configure the logger behavior
/// See [LogOptions.defaultOptions] for default options
///
/// [handlePrint] - Handle [print] functions in current zone
/// [printColors] - Print with colors using ASCII escape codes
/// [outputInRelease] - Output messages to the console in the release
/// [printStackTrace] - Print StackTrace
/// [useEmoji] - Use emoji in output messages instead of text symbols
/// [messageFormatting] - Output message formatting callback
/// [stackTraceFormatting] - Output StackTrace formatting callback
@immutable
abstract class LogOptions {
  /// Logger options
  const factory LogOptions({
    bool handlePrint,
    bool printColors,
    bool outputInRelease,
    bool printStackTrace,
    bool useEmoji,
    MessageFormatting? messageFormatting,
    StackTraceFormatting? stackTraceFormatting,
  }) = _LogOptionsImpl;

  const LogOptions._();

  /// Handle [print] functions in current zone
  abstract final bool handlePrint;

  /// Print with colors using ASCII escape codes
  /// If [useEmoji] is `true` then this option will be ignored
  abstract final bool printColors;

  /// Output messages to the console in the release
  abstract final bool outputInRelease;

  /// Print StackTrace
  abstract final bool printStackTrace;

  /// Use emoji in output messages
  abstract final bool useEmoji;

  /// Output message formatting callback
  abstract final MessageFormatting? messageFormatting;

  /// Output StackTrace formatting callback
  /// By default [StackTrace] will be formatted using [stack_trace.Trace.format]
  /// If [printStackTrace] is `false` then this option will be ignored
  abstract final StackTraceFormatting? stackTraceFormatting;

  /// Default Logger options
  static const defaultOptions = _LogOptionsImpl();
}

class _LogOptionsImpl extends LogOptions {
  const _LogOptionsImpl({
    this.handlePrint = true,
    this.printColors = true,
    this.outputInRelease = false,
    this.printStackTrace = true,
    this.useEmoji = false,
    this.messageFormatting,
    this.stackTraceFormatting,
  }) : super._();

  @override
  final bool handlePrint;

  @override
  final bool printColors;

  @override
  final bool outputInRelease;

  @override
  final bool printStackTrace;

  @override
  final bool useEmoji;

  @override
  final MessageFormatting? messageFormatting;

  @override
  final StackTraceFormatting? stackTraceFormatting;
}
