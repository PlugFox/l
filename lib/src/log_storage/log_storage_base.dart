import 'dart:async' show FutureOr;
import '../log_message.dart';

typedef LogWriter = FutureOr<void> Function(LogMessage logMessage);

/// Log storage
abstract class LogStorage {
  /// Constructor
  LogStorage._();

  /// Init object
  FutureOr<void> init();

  /// Kill object
  FutureOr<void> dispose();

  /// Write log
  FutureOr<void> write(LogMessage logMessage);

  /// Clear console
  FutureOr<void> clear();
}
