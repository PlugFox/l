import 'dart:async';
import 'dart:collection';

import 'package:meta/meta.dart' show mustCallSuper;

import 'log_level.dart';
import 'log_level_map.dart' show logLevelsAllocation;
import 'log_message.dart';
import 'log_progress.dart';
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
/// | Method       | Description                       |
/// |--------------|-----------------------------------|
/// | [lvl]        | Limiting output level (r: 3, d: 6)|
/// | [store]      | Set to true to save logs (false)  |
/// | [wide]       | Display wide prefix entry (false) |
/// | [pause]      | Pause for message queue           |
/// | [resume]     | Continued after a pause           |
/// | [clear]      | Console cleaning                  |
/// | [length]     | Logger max line length            |
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
  /// Access to the Singleton instance of [L]ogger
  static L get instance => _instance;

  /// Short form to access the instance of [L]ogger
  static L get I => _instance;

  /// Factory singleton instance of [L]ogger
  static final L _instance = L._internalSingleton();
  L._internalSingleton();

  /// A shout is always displayed
  void s(Object message) =>
      super.log(message.toString().toUpperCase(), LogLevel.shout);

  /// Regular message with verbose level 1
  void v(Object message) => super.log(message, LogLevel.v);

  /// Regular message with verbose level 2
  void vv(Object message) => super.log(message, LogLevel.vv);

  /// Regular message with verbose level 3
  void vvv(Object message) => super.log(message, LogLevel.vvv);

  /// Regular message with verbose level 4
  void vvvv(Object message) => super.log(message, LogLevel.vvvv);

  /// Regular message with verbose level 5
  void vvvvv(Object message) => super.log(message, LogLevel.vvvvv);

  /// Regular message with verbose level 6
  void vvvvvv(Object message) => super.log(message, LogLevel.vvvvvv);

  /// Inform message with verbose level 3
  void i(Object message) => super.log(message, LogLevel.info);

  /// Warning message with verbose level 2
  void w(Object message) => super.log(message, LogLevel.warning);

  /// Error message with verbose level 1
  void e(Object message) => super.log(message, LogLevel.error);

  /// Debug message with verbose level 4
  void d(Object message) => super.log(message, LogLevel.debug);

  /// Progress bar
  ///
  /// percent is int in range 0..100
  ///
  /// ```
  ///       {{header}}
  /// [======{{data}}=>   ]
  ///              {{footer}}
  /// ```
  ///
  /// !!! Use [l.resume()] after complete !!!
  void p({String header, String data, String footer, int percent = 0}) {
    pause();
    Progress.update(
        header: header, data: data, footer: footer, percent: percent);
  }

  /// Decrement log level
  void operator -(int v) => lvl = lvl - v;

  /// Increment log level
  void operator +(int v) => lvl = lvl + v;

  /// ________________
  /// Small easter egg
  ///  ¯\_(o . O,)_/¯
  void operator ~() => s(r'¯\_(@ . @,)_/¯');

  /// Add Inform message with verbose level 3
  void operator <(Object info) => i(info);

  /// Add Debug message with verbose level 4
  void operator <<(Object debug) => d(debug);

  @override
  final int hashCode = 0;
  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) => other is L;
  @override
  String toString() => '[L]ogger';
}

/// Engine for [L]ogger
class _LEngine {
  static final StreamController<LogMessage> _queue =
      StreamController<LogMessage>.broadcast();
  static final LogStorage _logStorage = logStorage;
  static const Map<int, List<LogLevel>> _logLevelsAllocation =
      logLevelsAllocation;

  static const bool _kIsRelease =
      bool.fromEnvironment('dart.vm.product', defaultValue: true);
  static const int _defaultLvl = _kIsRelease ? 3 : 6;
  static const bool _defaultStore = false;
  static const bool _defaultWide = false;

  StreamSubscription<void> _subscription;

  int _currentLvl;

  bool _store;

  bool _wide;

  _LEngine() {
    _store = _defaultStore;
    _currentLvl = _defaultLvl;
    _wide = _defaultWide;
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
  set store(bool v) => _store = v ?? true;

  /// Display wide prefix entry
  bool get wide => _wide ?? false;

  /// Display wide prefix entry
  set wide(bool v) => _wide = v ?? false;

  /// Continued after a pause
  @mustCallSuper
  void resume() {
    if (!isPaused) return;
    _subscription?.resume();
    Progress.discard();
  }

  /// Pause for message queue
  @mustCallSuper
  void pause() {
    if (isPaused) return;
    _subscription?.pause();
  }

  /// Message queie is paused?
  bool get isPaused => _subscription?.isPaused;

  /// Console cleaning (if a terminal is connected)
  FutureOr<void> clear() => _logStorage?.clear();

  /// Close [L]ogger
  /// Caution, this is permanent!
  @mustCallSuper
  Future<void> close() async {
    pause();
    Progress.discard();
    await _queue.close();
    // ignore: avoid_annotating_with_dynamic
    await _queue.stream.last.catchError((dynamic err) => null);
    await _subscription?.cancel();
    await _logStorage?.dispose();
  }

  /// Start log iterator
  void _startLogIterator() {
    // Controller for stream iterrator
    final _controller = StreamController<LogMessage>(
      onResume: () => _subscription.resume(),
      onPause: () => _subscription.pause(),
      onCancel: () => _subscription.cancel(),
      sync: true,
    ) as SynchronousStreamController<LogMessage>;
    // Iterator for stream with log message
    final _logIterator = StreamIterator<LogMessage>(_controller.stream);
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
    final _resultSC =
        StreamController<void>(sync: true) as SynchronousStreamController<void>;
    Future.doWhile(() => iterator.moveNext().then<bool>((hasNext) => hasNext
        ? _doTask(iterator.current, writer)
            .then<void>(_resultSC.sink.add)
            .then<bool>((_) => true)
        // ignore: avoid_annotating_with_dynamic
        : _resultSC?.close()?.then<bool>((dynamic _) => false) ??
            Future<bool>.value(false)));
    return _resultSC.stream;
  }

  Future<void> _doTask(LogMessage logMessage, LogWriter writer) async {
    final iterator = mw.iterator;
    final Future<void> mws = Future.doWhile(() async {
      if (!iterator.moveNext()) return false;
      if (iterator.current == null) return true;
      await iterator.current(logMessage);
      return true;
    });
    await writer(logMessage);
    await mws;
    return;
  }

  /// Add log to queue
  void log(Object message, LogLevel prefix) {
    try {
      final displayInConsole =
          _logLevelsAllocation[_currentLvl]?.contains(prefix) ?? false;
      final _now = DateTime.now();
      _queue.sink.add(
        LogMessage(
          date: _now,
          message: message,
          level: prefix,
          displayInConsole: displayInConsole,
          store: _store,
          wide: _wide,
        ),
      );
    } on dynamic catch (_) {
      if (!_kIsRelease) rethrow;
    }
  }

  void _setCurrentLvl(int value) =>
      _currentLvl = (value is int ? value : _defaultLvl).clamp(0, 6).toInt();

  int _getCurrentLvl() =>
      (_currentLvl is int ? _currentLvl : _defaultLvl).clamp(0, 6).toInt();
}
