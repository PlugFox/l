import 'dart:async' show FutureOr;
import 'dart:html' as html show window, Console;
import 'dart:indexed_db' as idb;
import '../log_level.dart';
import '../log_message.dart';
import 'log_storage_base.dart';

///
LogStorage getLogStorage() => LogStorageHTML();

/// HTML
class LogStorageHTML implements LogStorage {
  idb.Database _db;
  html.Console _console;
  bool _isInit = false;

  /// Init
  LogStorageHTML();

  /// Init
  @override
  FutureOr<void> init() async {
    if (_isInit) return null;
    _console = html.window.console;
    await _openIDB();
    _isInit = true;
  }

  /// Clear console
  @override
  FutureOr<void> clear() async {
    await init();
    _console.clear(null);
  }

  /// Dispose
  @override
  FutureOr<void> dispose() async {
    if (!_isInit) return null;
    _isInit = false;
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
    switch (logMessage.level) {
      case LogLevel.shout:
        _console.warn(_message);
        break;
      case LogLevel.v:
        _console.log(_message);
        break;
      case LogLevel.vv:
        _console.log(_message);
        break;
      case LogLevel.vvv:
        _console.log(_message);
        break;
      case LogLevel.vvvv:
        _console.log(_message);
        break;
      case LogLevel.vvvvv:
        _console.log(_message);
        break;
      case LogLevel.vvvvvv:
        _console.log(_message);
        break;
      case LogLevel.info:
        _console.info(_message);
        break;
      case LogLevel.warning:
        _console.warn(_message);
        break;
      case LogLevel.error:
        _console.error(_message);
        break;
      case LogLevel.debug:
        _console.debug(_message);
        break;
      default:
        _console.log(_message);
        break;
    }
    //print(_message);
  }

  FutureOr<void> _storeMessage(LogMessage logMessage) async {
    if (_db is! idb.Database || !logMessage.store) return;
    final tx = _db.transaction('logs', 'readwrite');
    final store = tx.objectStore('logs');
    if (store is! idb.ObjectStore) return;
    await store.add(logMessage.toMap());
    return tx.completed;
  }

  FutureOr<void> _openIDB() async {
    if (!idb.IdbFactory.supported) return null;
    void _createLogObjectStore(idb.Database db) {
      db.createObjectStore('logs', autoIncrement: true)
        ..createIndex('lvl_idx', 'level', unique: false)
        ..createIndex('date_idx', 'date', unique: false);
    }

    void _initializeDatabase(idb.VersionChangeEvent e) =>
        _createLogObjectStore(e.target.result as idb.Database);

    _db = await html.window.indexedDB
        .open('l', version: 1, onUpgradeNeeded: _initializeDatabase);
    if (_db is idb.Database &&
        !_db.objectStoreNames.join(';').contains('logs')) {
      _createLogObjectStore(_db);
    }
  }
}
