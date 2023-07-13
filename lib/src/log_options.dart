import 'package:meta/meta.dart';

import 'log_level.dart';

/// Output message formatting
typedef MessageFormatting = Object Function(
  Object message,
  LogLevel logLevel,
  DateTime dateTime,
);

/// Override output message formatting
typedef OverrideLoggerOutput = String? Function(
  Object message,
  LogLevel logLevel,
  DateTime dateTime,
);

/// Logger options
@immutable
abstract base class LogOptions {
  /// Logger options
  const factory LogOptions({
    bool handlePrint,
    bool printColors,
    bool outputInRelease,
    MessageFormatting? messageFormatting,
    OverrideLoggerOutput? overrideOutput,
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

  /// Output message formatting callback, allow to implement custom formatting
  /// and your own printing logic for output messages.
  /// If returns `null` then the message
  /// will not be output by the default logger.
  /// E.g. useful for JSON output, or output to a file/database/server.
  OverrideLoggerOutput? get overrideOutput;

  /// Default Logger options
  static const LogOptions defaultOptions = _LogOptionsImpl();
}

final class _LogOptionsImpl extends LogOptions {
  const _LogOptionsImpl({
    this.handlePrint = true,
    this.printColors = true,
    this.outputInRelease = false,
    this.messageFormatting,
    this.overrideOutput,
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
  final OverrideLoggerOutput? overrideOutput;
}
