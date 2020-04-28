import 'dart:async';
import 'dart:math' as math;

import 'log_level.dart';
import 'log_message.dart';
import 'log_storage.dart';

/// [L]ogger
///
/// Release:
///  + 1 - v, e
///  + 2 - vv, w
///  + 3 - vvv, i
///
/// Debug:
///  + 4 - vvvv, d
///  + 5 - vvvvv
///  + 6 - vvvvvv
///
class L {
  static final StreamController<LogMessage> _queue =
      StreamController<LogMessage>();
  static final LogStorage _logStorage = logStorage;
  static const Map<int, List<LogLevel>> _logLevelsAllocation =
      logLevelsAllocation;

  StreamSubscription<void> _subscription;
  int _currentLvl;

  /// Set new log level
  void set lvl(int newLevel) => _currentLvl =
      math.min(math.max(newLevel is int ? newLevel : _defaultLvl, 1), 6);
  int get lvl => _currentLvl;
  int get _defaultLvl => const bool.fromEnvironment('dart.vm.product') ? 3 : 6;

  /// Factory singleton instance of [L]ogger
  factory L() => _instance;
  static final L _instance = L._internalSingleton();
  L._internalSingleton() {
    _currentLvl = _defaultLvl;
    _startLogIterator();
  }

  /// Verbose level 1
  void v(dynamic message) => _l(message, LogLevel.v);

  /// Verbose level 2
  void vv(dynamic message) => _l(message, LogLevel.vv);

  /// Verbose level 3
  void vvv(dynamic message) => _l(message, LogLevel.vvv);

  /// Verbose level 4
  void vvvv(dynamic message) => _l(message, LogLevel.vvvv);

  /// Verbose level 5
  void vvvvv(dynamic message) => _l(message, LogLevel.vvvvv);

  /// Verbose level 6
  void vvvvvv(dynamic message) => _l(message, LogLevel.vvvvvv);

  /// Info
  void i(dynamic message) => _l(message, LogLevel.info);

  /// Warning
  void w(dynamic message) => _l(message, LogLevel.warning);

  /// Error
  void e(dynamic message) => _l(message, LogLevel.error);

  /// Debug
  void d(dynamic message) => _l(message, LogLevel.debug);

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
          displayInConsole: displayInConsole));
      // ignore: unused_catch_stack
    } on dynamic catch (error, stackTrace) {
      bool releaseMode = true;
      assert(() {
        releaseMode = false;
      }());
      if (!releaseMode) rethrow;
    }
  }

  /// Resume [L]ogger
  void resume() => _subscription?.resume();

  /// Pause [L]ogger
  void pause() => _subscription?.pause();

  /// Close [L]gger
  /// Beware: permanent
  Future<void> close() => _queue
      .close()
      .whenComplete(() => _subscription?.cancel())
      .whenComplete(() => _logStorage?.dispose());

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

  @override
  final int hashCode = 0;
  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object obj) => obj is L;
  @override
  String toString() => '[L]ogger';

  /// Decrement log level
  void operator -(int v) => lvl = (_currentLvl - v);

  /// Increment log level
  void operator +(int v) => lvl = (_currentLvl + v);

  /// Add info message
  void operator <(Object verbose) => i(verbose);

  /// Add debug message
  void operator <<(Object verbose) => d(verbose);
}
