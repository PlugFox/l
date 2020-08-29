import 'dart:async' show FutureOr;
import 'dart:io' as io;

import '../log_level.dart';
import '../log_message.dart';
import 'log_storage_base.dart';

///
LogStorage getLogStorage() => LogStorageIO();

/// I/O
class LogStorageIO implements LogStorage {
  String _logPath;
  bool _writeAccess;
  bool _hasTerminal = false;
  io.Stdout get _console => io.stdout;
  bool _isInit = false;
  bool _ansi = false;

  /// Init
  LogStorageIO();

  /// Init
  @override
  FutureOr<void> init() async {
    if (_isInit) return;
    _hasTerminal = io.stdout.hasTerminal;
    if (_hasTerminal) {
      _ansi = _console.supportsAnsiEscapes;
    }
    _logPath = io.Directory.current.path;
    if (!_logPath.endsWith(io.Platform.pathSeparator)) {
      _logPath += io.Platform.pathSeparator;
    }
    _logPath += 'l${io.Platform.pathSeparator}';
    _isInit = true;
    return;
  }

  /// Clear console
  @override
  FutureOr<void> clear() async {
    await init();
    if (_console != null) {
      await _console.flush();
    }
  }

  /// Dispose
  @override
  FutureOr<void> dispose() async {
    if (!_isInit) return null;
    _isInit = false;
    /*
    if (_console != null) {
      await _console.close();
      _console = null;
    }
    */
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

  void _print(LogMessage logMessage) {
    final _message = logMessage.toString();
    if (_hasTerminal) {
      _console.writeln(_formatMessage(_message, logMessage.level));
    } else {
      // ignore: avoid_print
      print(_message);
    }
  }

  FutureOr<void> _storeMessage(LogMessage logMessage) async {
    if (!logMessage.store || !_hasWriteAccess()) return;
    final fileName = '${_logPath}logs_'
        '${logMessage.date.year.toString().padLeft(4, '0')}-'
        '${logMessage.date.month.toString().padLeft(2, '0')}-'
        '${logMessage.date.day.toString().padLeft(2, '0')}'
        '.txt';
    var file = io.File(fileName);
    if (!file.existsSync()) {
      file = await file.create(recursive: true);
      //await file.writeAsString('    UNIX TIME  ______  LOGS',
      //    mode: io.FileMode.writeOnlyAppend);
    }
    return file.writeAsString(
        '\r\n${logMessage.date.millisecondsSinceEpoch} '
        '${logMessage.toString()}',
        mode: io.FileMode.writeOnlyAppend);
  }

  String _formatMessage(String message, LogLevel lvl) {
    if (!_ansi) return message;
    switch (lvl) {
      case LogLevel.shout:
        return _addFgBgDc(message, dc: 'underline', fg: 'black', bg: 'white');
      case LogLevel.v:
        return _addFgBgDc(message, dc: 'bold', fg: 'magenta', bg: '');
      case LogLevel.vv:
        return _addFgBgDc(message, dc: '', fg: '', bg: '');
      case LogLevel.vvv:
        return _addFgBgDc(message, dc: '', fg: '', bg: '');
      case LogLevel.vvvv:
        return _addFgBgDc(message, dc: '', fg: '', bg: '');
      case LogLevel.vvvvv:
        return _addFgBgDc(message, dc: '', fg: '', bg: '');
      case LogLevel.vvvvvv:
        return _addFgBgDc(message, dc: '', fg: '', bg: '');
      case LogLevel.info:
        return _addFgBgDc(message, dc: '', fg: 'green', bg: '');
      case LogLevel.warning:
        return _addFgBgDc(message, dc: '', fg: 'yellow', bg: '');
      case LogLevel.error:
        return _addFgBgDc(message, dc: 'bold', fg: 'white', bg: 'red');
      case LogLevel.debug:
        return _addFgBgDc(message, dc: '', fg: 'cyan', bg: '');
      default:
        return _addFgBgDc(message, dc: '', fg: '', bg: '');
    }
  }

  String _addFgBgDc(String message, {String dc, String fg, String bg}) {
    final dcString = _decorations[dc];
    final fgString = _fgColors[fg];
    final bgString = _bgColors[bg];
    var result = message;
    if (dcString is String) {
      result = '$_esc$dcString$message$_esc$_reset';
    }
    if (fgString is String) {
      result = '$_esc$fgString$message$_esc$_reset';
    }
    if (bgString is String) {
      result = '$_esc$bgString$message$_esc$_reset';
    }
    return result;
  }

  bool _hasWriteAccess() {
    if (_writeAccess is bool) return _writeAccess;
    try {
      io.Directory(_logPath).createSync(recursive: false);
      _writeAccess = true;
      // ignore: unused_catch_clause
    } on dynamic catch (error) {
      _writeAccess = false;
    }
    return _writeAccess;
  }
}

/// Ansi escape
const String _esc = '\x1B[';
const String _reset = '0m';

/// Ansi foreground colors for terminal
const Map<String, String> _fgColors = <String, String>{
  'black': '30m',
  'red': '31m',
  'green': '32m',
  'yellow': '33m',
  'blue': '34m',
  'magenta': '35m',
  'cyan': '36m',
  'white': '37m',
};

/// Ansi background colors for terminal
const Map<String, String> _bgColors = <String, String>{
  'black': '40m',
  'red': '41m',
  'green': '42m',
  'yellow': '43m',
  'blue': '44m',
  'magenta': '45m',
  'cyan': '46m',
  'white': '47m',
};

/// Ansi decorations for terminal
const Map<String, String> _decorations = <String, String>{
  'bold': '1m',
  'underline': '4m',
  'reversed': '7m',
};
