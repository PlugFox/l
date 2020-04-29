import 'dart:async';
import 'dart:math' as math;

import 'package:meta/meta.dart' show mustCallSuper;

import 'log_level.dart';
import 'log_message.dart';
import 'log_storage.dart';

/// [L]ogger
///
/// Verbose levels:
///  * Release:
///    + 1 - v, e
///    + 2 - vv, w
///    + 3 - vvv, i
///  * Debug:
///    + 4 - vvvv, d
///    + 5 - vvvvv
///    + 6 - vvvvvv
///
class L extends _LEngine {
  /// Factory singleton instance of [L]ogger
  factory L() => _instance;
  static final L _instance = L._internalSingleton();
  L._internalSingleton();

  /// Verbose level 1
  void v(dynamic message) => super._l(message, LogLevel.v);

  /// Verbose level 2
  void vv(dynamic message) => super._l(message, LogLevel.vv);

  /// Verbose level 3
  void vvv(dynamic message) => super._l(message, LogLevel.vvv);

  /// Verbose level 4
  void vvvv(dynamic message) => super._l(message, LogLevel.vvvv);

  /// Verbose level 5
  void vvvvv(dynamic message) => super._l(message, LogLevel.vvvvv);

  /// Verbose level 6
  void vvvvvv(dynamic message) => super._l(message, LogLevel.vvvvvv);

  /// Info
  void i(dynamic message) => super._l(message, LogLevel.info);

  /// Warning
  void w(dynamic message) => super._l(message, LogLevel.warning);

  /// Error
  void e(dynamic message) => super._l(message, LogLevel.error);

  /// Debug
  void d(dynamic message) => super._l(message, LogLevel.debug);

  /// Decrement log level
  void operator -(int v) => lvl = (lvl - v);

  /// Increment log level
  void operator +(int v) => lvl = (lvl + v);

  /// Add info message
  void operator <(Object verbose) => i(verbose);

  /// Add debug message
  void operator <<(Object verbose) => d(verbose);

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
  bool _storeLogs;

  _LEngine() {
    _currentLvl = _defaultLvl;
    _startLogIterator();
  }

  /// Set new log level in range 0..6
  set lvl(int newLevel) => _setCurrentLvl(newLevel);

  /// Get current log level in range 0..6
  int get lvl => _getCurrentLvl();

  /// Store logs?
  bool get storeLogs => _storeLogs;

  /// Set bool store logs
  set storeLogs(bool v) => _storeLogs = (v ?? true);

  /// Resume [L]ogger
  @mustCallSuper
  void resume() => _subscription?.resume();

  /// Pause [L]ogger
  @mustCallSuper
  void pause() => _subscription?.pause();

  /// Clear [L]ogger console
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
            ? Future<void>.value(writer(iterator.current))
                .then<void>(_resultSC.sink.add)
                .then<bool>((void _) => true)
            : _resultSC?.close()?.then<bool>((void _) => false) ??
                Future<bool>.value(false)));
    return _resultSC.stream;
  }

  /// Add log to queue
  void _l(Object message, LogLevel prefix) {
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
          store: _storeLogs));
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
