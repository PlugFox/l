import 'package:meta/meta.dart';

import '../../l.dart';
import 'log_delegate.dart';

/// Ignore all log messages
@internal
LogDelegate createEnvironmentLogDelegate() => LogDelegate$Ignore();

@internal
final class LogDelegate$Ignore implements LogDelegate {
  LogDelegate$Ignore();

  @override
  void log(LogMessage event) {/* ignore */}
}
