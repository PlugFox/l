import 'dart:async' show FutureOr;
import '../log_message.dart';
import 'log_storage_base.dart';

///
LogStorage getLogStorage() {
  const releaseMode = bool.fromEnvironment(
    'dart.vm.product',
    defaultValue: true,
  );
  if (!releaseMode) {
    throw UnsupportedError('Unknown unsupported platform for logger');
  }
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
      const releaseMode = bool.fromEnvironment(
        'dart.vm.product',
        defaultValue: true,
      );
      if (!releaseMode) rethrow;
    }
    return;
  }

  void _print(LogMessage logMessage) =>
      print(logMessage.toString()); // ignore: avoid_print

  FutureOr<void> _storeMessage(LogMessage logMessage) async {
    if (!logMessage.store) return;
    return Future<void>.value(null);
  }
}
