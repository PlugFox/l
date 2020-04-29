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

/// HashMap with LogLevels
const Map<int, List<LogLevel>> logLevelsAllocation = <int, List<LogLevel>>{
  0: <LogLevel>[],
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

/// HashMap with Levels
const Map<LogLevel, int> levelsAllocation = <LogLevel, int>{
  LogLevel.v: 1,
  LogLevel.error: 1,
  LogLevel.vv: 2,
  LogLevel.warning: 2,
  LogLevel.vvv: 3,
  LogLevel.info: 3,
  LogLevel.vvvv: 4,
  LogLevel.debug: 4,
  LogLevel.vvvvv: 5,
  LogLevel.vvvvvv: 6,
};
