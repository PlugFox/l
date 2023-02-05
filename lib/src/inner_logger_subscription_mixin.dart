@internal
import 'dart:async';

import 'package:meta/meta.dart';

import 'inner_logger.dart';
import 'log_message.dart';

/// {@nodoc}
mixin InnerLoggerSubscriptionMixin on InnerLogger {
  /// Whether there is a subscriber on the [Stream].
  bool get hasListener => _controller.hasListener;

  final StreamController<LogMessage> _controller =
      StreamController<LogMessage>.broadcast();

  @override
  StreamSubscription<LogMessage> listen(
    void Function(LogMessage event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError = false,
  }) =>
      _controller.stream.listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError ?? false,
      );

  @override
  @internal
  void notifyListeners(LogMessage logMessage) {
    if (!hasListener) return;
    _controller.add(logMessage);
  }
}
