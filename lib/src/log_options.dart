import 'package:meta/meta.dart';

import '../l.dart';

/// Log output destination
enum LogOutput {
  /// Output to platform-specific output
  /// such as `stdout` at VM or `console` at Web.
  platform,

  /// Output to `Zone.root.print` function
  print,

  /// Use `dart:developer` library for output
  developer,

  /// Ignore output
  ignore,
}

/// Output message formatting
typedef MessageFormatting = Object Function(LogMessage event);

/// Override output message formatting
typedef OverrideLoggerOutput = String? Function(LogMessage event);

/// Logger options
@immutable
abstract base class LogOptions {
  /// Logger options
  const factory LogOptions({
    bool handlePrint,
    bool printColors,
    bool outputInRelease,
    LogOutput output,
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

  /// Output destination, default is `platform`
  /// Allow to change the output destination to `print` or `dart:developer`
  LogOutput get output;

  /// Output message formatting callback
  MessageFormatting? get messageFormatting;

  /// Output message formatting callback, allow to implement custom formatting
  /// and your own printing logic for output messages.
  /// If returns `null` then the message
  /// will not be output by the default logger.
  /// E.g. useful for JSON output, or output to a file/database/server.
  ///
  /// **DO NOT USE `print(msg)` INSIDE THIS FUNCTION!**
  /// **IT WILL CAUSE AN INFINITE LOOP!**
  /// Just return a formatted string for standard output,
  /// or use `stdout.write(msg)` / `stderr.write(err)`
  /// or your own output logic.
  OverrideLoggerOutput? get overrideOutput;

  /// Default Logger options
  static const LogOptions defaultOptions = _LogOptionsImpl();
}

final class _LogOptionsImpl extends LogOptions {
  const _LogOptionsImpl({
    this.handlePrint = true,
    this.printColors = true,
    this.outputInRelease = false,
    this.output = LogOutput.platform,
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
  final LogOutput output;

  @override
  final MessageFormatting? messageFormatting;

  @override
  final OverrideLoggerOutput? overrideOutput;
}
