import 'dart:async' show FutureOr;
import 'dart:io' as io;
import '../log_message.dart';
import 'log_storage_base.dart';

///
LogStorage getLogStorage() => LogStorageIO();

/// I/O
class LogStorageIO implements LogStorage {
  io.Stdout _console;
  bool _isInit = false;

  /// Init
  LogStorageIO() {
    init();
  }

  /// Init
  @override
  void init() {
    if (_isInit) return;
    _console = io.stdout;
    _isInit = true;
  }

  /// Dispose
  @override
  FutureOr<void> dispose() async {
    await _console.flush();
    await _console.close();
    _console = null;
  }

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
    _console.writeln(_message);
    //print(_message);
  }
}
