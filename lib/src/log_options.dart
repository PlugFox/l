import 'package:meta/meta.dart';

import 'log_level.dart';

/// Output message formatting
typedef MessageFormatting = Object Function(
    Object message, LogLevel logLevel, DateTime dateTime);

/// Logger options
@experimental
@immutable
abstract class LogOptions {
  /// Handle `print` function in current zone
  bool get handlePrint;

  /// Output message formatting callback
  MessageFormatting? get messageFormatting;

  /// Logger options
  @experimental
  const factory LogOptions({
    bool handlePrint,
    MessageFormatting? messageFormatting,
  }) = _LogOptionsImpl;

  const LogOptions._();

  /// Default Logger options
  static const defaultOptions = _LogOptionsImpl();
}

class _LogOptionsImpl extends LogOptions {
  @override
  final bool handlePrint;

  @override
  final MessageFormatting? messageFormatting;

  const _LogOptionsImpl({
    this.handlePrint = true,
    this.messageFormatting,
  }) : super._();
}
