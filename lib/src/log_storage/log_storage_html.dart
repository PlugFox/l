import 'dart:async' show FutureOr;
import 'dart:html' as html show window, Console;
import '../log_level.dart';
import '../log_message.dart';
import 'log_storage_base.dart';

///
LogStorage getLogStorage() => LogStorageHTML();

/// HTML
class LogStorageHTML implements LogStorage {
  html.Console _console;
  bool _isInit = false;

  /// Init
  LogStorageHTML() {
    init();
  }

  /// Init
  @override
  void init() {
    if (_isInit) return;
    _console = html.window.console;
    _isInit = true;
  }

  /// Dispose
  @override
  FutureOr<void> dispose() {
    _console.clear(null);
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
    switch (logMessage.level) {
      case (LogLevel.v):
        _console.log(_message);
        break;
      case (LogLevel.vv):
        _console.log(_message);
        break;
      case (LogLevel.vvv):
        _console.log(_message);
        break;
      case (LogLevel.vvvv):
        _console.log(_message);
        break;
      case (LogLevel.vvvvv):
        _console.log(_message);
        break;
      case (LogLevel.vvvvvv):
        _console.log(_message);
        break;
      case (LogLevel.info):
        _console.info(_message);
        break;
      case (LogLevel.warning):
        _console.warn(_message);
        break;
      case (LogLevel.error):
        _console.error(_message);
        break;
      case (LogLevel.debug):
        _console.debug(_message);
        break;
      default:
        _console.log(_message);
        break;
    }
    //print(_message);
  }
}
