import 'dart:async' show FutureOr;
import 'dart:io' as io;
import '../log_message.dart';
import 'log_storage_base.dart';

///
LogStorage getLogStorage() => LogStorageIO();

/// I/O
class LogStorageIO implements LogStorage {
  final String _logPath = '${io.Directory.current.path}'
      '${io.Platform.pathSeparator}l'
      '${io.Platform.pathSeparator}';
  io.Stdout _console;
  bool _isInit = false;

  /// Init
  LogStorageIO();

  /// Init
  @override
  FutureOr<void> init() async {
    if (_isInit) return null;
    _console = io.stdout;
    _isInit = true;
  }

  /// Clear console
  @override
  FutureOr<void> clear() async {
    await init();
    await _console.flush();
  }

  /// Dispose
  @override
  FutureOr<void> dispose() async {
    if (!_isInit) return null;
    _isInit = false;
    await _console.close();
    _console = null;
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
    _console.writeln(_message);
    //print(_message);
  }

  FutureOr<void> _storeMessage(LogMessage logMessage) async {
    if (!logMessage.store) return;
    final String fileName = '${_logPath}logs_'
        '${logMessage.date.year.toString().padLeft(4, '0')}-'
        '${logMessage.date.month.toString().padLeft(2, '0')}-'
        '${logMessage.date.day.toString().padLeft(2, '0')}'
        '.txt';
    io.File file = io.File(fileName);
    if (!file.existsSync()) {
      file = await file.create(recursive: true);
      await file.writeAsString('    UNIX TIME  ______  LOGS',
          mode: io.FileMode.writeOnlyAppend);
    }
    return file.writeAsString(
        '\r\n${logMessage.date.millisecondsSinceEpoch} '
        '${logMessage.toString()}',
        mode: io.FileMode.writeOnlyAppend);
  }
}
