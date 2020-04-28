// ignore_for_file: avoid_print
import 'dart:async' show FutureOr;
import 'log_storage_base.dart';
import '../log_message.dart';

///
LogStorage getLogStorage() {
  assert(() {
    throw UnsupportedError('Unknown unsupported platform for logger');
  }());
  return LogStorageStub();
}

/// Stub
class LogStorageStub implements LogStorage {
  bool _isInit = false;

  ///
  LogStorageStub() {
    init();
  }

  /// Init
  @override
  void init() {
    if (_isInit) return;
    _isInit = true;
  }

  /// Dispose
  @override
  FutureOr<void> dispose() => null;

  /// Write to store and console
  @override
  FutureOr<void> write(LogMessage logMessage) {
    try {
      if (logMessage.print) _log(logMessage);
    } on dynamic catch (_) {
      bool releaseMode = true;
      assert(() {
        releaseMode = false;
      }());
      if (!releaseMode) rethrow;
    }
  }

  void _log(LogMessage logMessage) {
    final String _message = logMessage.toString();
    print(_message);
  }
}
