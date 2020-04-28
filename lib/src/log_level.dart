/// Log level
enum LogLevel {
  /// verbose level 1
  v,

  /// verbose level 2
  vv,

  /// verbose level 3
  vvv,

  /// verbose level 4
  vvvv,

  /// verbose level 5
  vvvvv,

  /// verbose level 6
  vvvvvv,

  /// info
  info,

  /// warning
  warning,

  /// error
  error,

  /// debug
  debug,
}

const Map<int, List<LogLevel>> logLevelsAllocation = <int, List<LogLevel>>{
  1: <LogLevel>[
    LogLevel.v,
    LogLevel.error,
  ],
  2: <LogLevel>[
    LogLevel.vv,
    LogLevel.warning,
    LogLevel.v,
    LogLevel.error,
  ],
  3: <LogLevel>[
    LogLevel.vvv,
    LogLevel.info,
    LogLevel.vv,
    LogLevel.warning,
    LogLevel.v,
    LogLevel.error,
  ],
  4: <LogLevel>[
    LogLevel.vvvv,
    LogLevel.debug,
    LogLevel.vvv,
    LogLevel.info,
    LogLevel.vv,
    LogLevel.warning,
    LogLevel.v,
    LogLevel.error,
  ],
  5: <LogLevel>[
    LogLevel.vvvvv,
    LogLevel.vvvv,
    LogLevel.debug,
    LogLevel.vvv,
    LogLevel.info,
    LogLevel.vv,
    LogLevel.warning,
    LogLevel.v,
    LogLevel.error,
  ],
  6: <LogLevel>[
    LogLevel.vvvvvv,
    LogLevel.vvvvv,
    LogLevel.vvvv,
    LogLevel.debug,
    LogLevel.vvv,
    LogLevel.info,
    LogLevel.vv,
    LogLevel.warning,
    LogLevel.v,
    LogLevel.error,
  ],
};
