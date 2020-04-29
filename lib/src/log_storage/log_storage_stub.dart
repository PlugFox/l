import 'dart:async' show FutureOr;
import '../log_message.dart';
import 'log_storage_base.dart';

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
  LogStorageStub();

  /// Init
  @override
  FutureOr<void> init() async {
    if (_isInit) return null;
    _isInit = true;
  }

  /// Clear console
  @override
  FutureOr<void> clear() async {
    await init();
  }

  /// Dispose
  @override
  FutureOr<void> dispose() {
    if (!_isInit) return null;
    _isInit = false;
  }

  /// Write to store and console
  @override
  FutureOr<void> write(LogMessage logMessage) async {
    try {
      await init();
      if (logMessage.print) _print(logMessage);
      await _storeMessage(logMessage);
    } on dynamic catch (_) {
      bool releaseMode = true;
      assert(() {
        releaseMode = false;
      }());
      if (!releaseMode) rethrow;
    }
    return;
  }

  void _print(LogMessage logMessage) {
    final String _message = logMessage.toString();
    // ignore: avoid_print
    print(_message);
  }

  FutureOr<void> _storeMessage(LogMessage logMessage) async {
    if (!logMessage.store) return;
    return Future<void>.value(null);
  }
}
