import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

import 'package:meta/meta.dart' show mustCallSuper;

import 'log_level.dart';
import 'log_level_map.dart' show logLevelsAllocation;
import 'log_message.dart';
import 'log_storage.dart';

/// [L]ogger
///
/// Cross-platform html/io Logger with simple API.
/// No need to create an object. Just import and use.
/// Simple and w/o boilerplate.
/// Work with native console and can store logs in
/// txt files (io) and indexedDB (web).
/// You can change verbose level and resume/pause
/// log queue, also you can clear console.
///
///
/// Key features
///
/// | Method   | Description                          |
/// |----------|--------------------------------------|
/// | [s]      | A shout is always displayed          |
/// | [v]      | Regular message with verbose level 1 |
/// | [e]      | Error message with verbose level 1   |
/// | [vv]     | Regular message with verbose level 2 |
/// | [w]      | Warning message with verbose level 2 |
/// | [vvv]    | Regular message with verbose level 3 |
/// | [i]      | Inform message with verbose level 3  |
/// | [vvvv]   | Regular message with verbose level 4 |
/// | [d]      | Debug message with verbose level 4   |
/// | [vvvvv]  | Regular message with verbose level 5 |
/// | [vvvvvv] | Regular message with verbose level 6 |
///
///
/// Setup and management
///
/// | Method      | Description                       |
/// |-------------|-----------------------------------|
/// | [lvl]       | Limiting output level (r: 3, d: 6)|
/// | [store]     | Set to true to save logs (false)  |
/// | [wide]      | Display wide prefix entry (false) |
/// | [pause]     | Pause for message queue           |
/// | [resume]    | Continued after a pause           |
/// | [clear]     | Console cleaning                  |
///
///
/// Integration capabilities
///
/// | Method      | Description                       |
/// |-------------|-----------------------------------|
/// | [stream]    | Broadcast stream receiving logs.  |
/// | [mw]        | Middleware queue with functions   |
///
///
class L extends _LEngine {
  /// Factory singleton instance of [L]ogger
  factory L() => _instance;
  static final L _instance = L._internalSingleton();
  L._internalSingleton();

  /// A shout is always displayed
  void s(dynamic message) =>
      super.log(message.toString().toUpperCase(), LogLevel.shout);

  /// Regular message with verbose level 1
  void v(dynamic message) => super.log(message, LogLevel.v);

  /// Regular message with verbose level 2
  void vv(dynamic message) => super.log(message, LogLevel.vv);

  /// Regular message with verbose level 3
  void vvv(dynamic message) => super.log(message, LogLevel.vvv);

  /// Regular message with verbose level 4
  void vvvv(dynamic message) => super.log(message, LogLevel.vvvv);

  /// Regular message with verbose level 5
  void vvvvv(dynamic message) => super.log(message, LogLevel.vvvvv);

  /// Regular message with verbose level 6
  void vvvvvv(dynamic message) => super.log(message, LogLevel.vvvvvv);

  /// Inform message with verbose level 3
  void i(dynamic message) => super.log(message, LogLevel.info);

  /// Warning message with verbose level 2
  void w(dynamic message) => super.log(message, LogLevel.warning);

  /// Error message with verbose level 1
  void e(dynamic message) => super.log(message, LogLevel.error);

  /// Debug message with verbose level 4
  void d(dynamic message) => super.log(message, LogLevel.debug);

  /// Decrement log level
  void operator -(int v) => lvl = (lvl - v);

  /// Increment log level
  void operator +(int v) => lvl = (lvl + v);

  /// ________________
  /// Small easter egg
  ///    ¯\_(ツ)_/¯
  void operator ~() => s(r'¯\_(ツ)_/¯');

  /// Add Inform message with verbose level 3
  void operator <(Object info) => i(info);

  /// Add Debug message with verbose level 4
  void operator <<(Object debug) => d(debug);

  @override
  final int hashCode = 0;
  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object obj) => obj is L;
  @override
  String toString() => r'[L]ogger';
}

/// Engine for [L]ogger
class _LEngine {
  static final StreamController<LogMessage> _queue =
      StreamController<LogMessage>.broadcast();
  static final LogStorage _logStorage = logStorage;
  static const Map<int, List<LogLevel>> _logLevelsAllocation =
      logLevelsAllocation;

  StreamSubscription<void> _subscription;
  int _currentLvl;
  static const int _defaultLvl =
      bool.fromEnvironment('dart.vm.product') ? 3 : 6;
  bool _store;

  bool _wide = false;

  /// Display wide prefix entry
  bool get wide => _wide ?? false;

  /// Display wide prefix entry
  set wide(bool v) => _wide = (v ?? false);

  _LEngine() {
    _store = false;
    _currentLvl = _defaultLvl;
    _startLogIterator();
  }

  /// Broadcast stream instantly receiving logs.
  final Stream<LogMessage> stream = _queue.stream;

  /// Middleware queue with functions
  final Queue<Future<void> Function(LogMessage)> mw =
      Queue<Future<void> Function(LogMessage)>();

  /// Limiting output level
  /// (default 3 in release, 6 in debug)
  /// Set new log level in range 0..6
  set lvl(int newLevel) => _setCurrentLvl(newLevel);

  /// Limiting output level
  /// (default 3 in release, 6 in debug)
  /// Get current log level in range 0..6
  int get lvl => _getCurrentLvl();

  /// Set to true to save logs
  /// (default is false)
  bool get store => _store;

  /// Set to true to save logs
  /// (default is false)
  set store(bool v) => _store = (v ?? true);

  /// Continued after a pause
  @mustCallSuper
  void resume() => _subscription?.resume();

  /// Pause for message queue
  @mustCallSuper
  void pause() => _subscription?.pause();

  /// Console cleaning (if a terminal is connected)
  FutureOr<void> clear() => _logStorage?.clear();

  /// Close [L]ogger
  /// Caution, this is permanent!
  @mustCallSuper
  Future<void> close() async {
    await _queue.close();
    await _queue.stream.last.catchError((Object _) => null);
    await _subscription?.cancel();
    await _logStorage?.dispose();
  }

  /// Start log iterator
  void _startLogIterator() {
    // Controller for stream iterrator
    final SynchronousStreamController<LogMessage> _controller =
        StreamController<LogMessage>(
      onResume: () => _subscription.resume(),
      onPause: () => _subscription.pause(),
      onCancel: () => _subscription.cancel(),
      sync: true,
    ) as SynchronousStreamController<LogMessage>;
    // Iterator for stream with log message
    final StreamIterator<LogMessage> _logIterator =
        StreamIterator<LogMessage>(_controller.stream);
    // Subscription with pause ability
    _subscription = _queue.stream.listen(
      _controller.add,
      onDone: _controller.close,
      onError: _controller.addError,
      cancelOnError: false,
    );
    // Run log iterator
    _iterateLog(_logIterator, logStorage.write);
  }

  /// Iterate log
  Stream<void> _iterateLog(
      StreamIterator<LogMessage> iterator, LogWriter writer) {
    SynchronousStreamController<void> _resultSC =
        StreamController<void>(sync: true) as SynchronousStreamController<void>;
    Future.doWhile(() => iterator.moveNext().then<bool>((bool hasNext) =>
        hasNext
            ? _doTask(iterator.current, writer)
                .then<void>(_resultSC.sink.add)
                .then<bool>((void _) => true)
            : _resultSC?.close()?.then<bool>((void _) => false) ??
                Future<bool>.value(false)));
    return _resultSC.stream;
  }

  Future<void> _doTask(LogMessage logMessage, LogWriter writer) async {
    Iterator<Future<void> Function(LogMessage)> iter = mw.iterator;
    Future<void> mws = Future.doWhile(() async {
      if (!iter.moveNext()) return false;
      if (iter.current == null) return true;
      await iter.current(logMessage);
      return true;
    });
    await writer(logMessage);
    await mws;
  }

  /// Add log to queue
  void log(Object message, LogLevel prefix) {
    try {
      bool displayInConsole;
      if (!(_logLevelsAllocation[_currentLvl]?.contains(prefix) ?? false)) {
        displayInConsole = false;
      } else {
        displayInConsole = true;
      }
      final DateTime _now = DateTime.now();
      _queue.sink.add(LogMessage(
          date: _now,
          message: message,
          level: prefix,
          displayInConsole: displayInConsole,
          store: _store,
          wide: _wide));
      // ignore: unused_catch_stack
    } on dynamic catch (error, stackTrace) {
      bool releaseMode = true;
      assert(() {
        releaseMode = false;
      }());
      if (!releaseMode) rethrow;
    }
  }

  void _setCurrentLvl(int lvl) =>
      _currentLvl = math.min(math.max(lvl is int ? lvl : _defaultLvl, 0), 6);

  int _getCurrentLvl() =>
      math.min(math.max(_currentLvl is int ? _currentLvl : _defaultLvl, 0), 6);
}
