import 'package:meta/meta.dart';

import 'log_level.dart';

/// Output message formatting
typedef MessageFormatting = Object Function(
  Object message,
  LogLevel logLevel,
  DateTime dateTime,
);

/// Output StackTrace formatting
typedef StackTraceFormatting = Object Function(
  StackTrace stackTrace,
);

/// Logger options
@experimental
@immutable
abstract class LogOptions {
  /// Logger options
  @experimental
  const factory LogOptions({
    bool handlePrint,
    bool printColors,
    bool outputInRelease,
    MessageFormatting? messageFormatting,
    StackTraceFormatting? stackTraceFormatting,
  }) = _LogOptionsImpl;

  const LogOptions._();

  /// Handle `print` function in current zone
  bool get handlePrint;

  /// Print with colors using ASCII escape codes
  bool get printColors;

  /// Output messages to the console in the release
  bool get outputInRelease;

  /// Output message formatting callback
  MessageFormatting? get messageFormatting;

  /// Output StackTrace formatting callback
  StackTraceFormatting? get stackTraceFormatting;

  /// Default Logger options
  static const defaultOptions = _LogOptionsImpl();
}

class _LogOptionsImpl extends LogOptions {
  const _LogOptionsImpl({
    this.handlePrint = true,
    this.printColors = true,
    this.outputInRelease = false,
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
  final MessageFormatting? messageFormatting;

  @override
  final StackTraceFormatting? stackTraceFormatting;
}
