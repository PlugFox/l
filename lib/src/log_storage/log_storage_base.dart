import 'dart:async' show FutureOr;
import '../log_message.dart';

typedef LogWriter = FutureOr<void> Function(LogMessage logMessage);

///
abstract class LogStorage {
  ///
  LogStorage._();

  /// Инициализировать
  void init();

  /// Уничтожить
  FutureOr<void> dispose();

  /// Запись в хранилище
  FutureOr<void> write(LogMessage logMessage);
}
