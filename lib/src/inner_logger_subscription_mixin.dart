import 'dart:async';

import 'inner_logger.dart';
import 'log_message.dart';

/// {@nodoc}
mixin InnerLoggerSubscriptionMixin on InnerLogger {
  final List<Function> _list = [];

  @override
  StreamSubscription<LogMessage> listen(
    void Function(LogMessage event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    // TODO: implement listen
    throw UnimplementedError();
  }
}
