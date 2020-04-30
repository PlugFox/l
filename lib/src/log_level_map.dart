import 'log_level.dart';

/// HashMap with LogLevels
const Map<int, List<LogLevel>> logLevelsAllocation = <int, List<LogLevel>>{
  0: <LogLevel>[
    LogLevel.shout,
  ],
  1: <LogLevel>[
    LogLevel.v,
    LogLevel.error,
    LogLevel.shout,
  ],
  2: <LogLevel>[
    LogLevel.vv,
    LogLevel.warning,
    LogLevel.v,
    LogLevel.error,
    LogLevel.shout,
  ],
  3: <LogLevel>[
    LogLevel.vvv,
    LogLevel.info,
    LogLevel.vv,
    LogLevel.warning,
    LogLevel.v,
    LogLevel.error,
    LogLevel.shout,
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
    LogLevel.shout,
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
    LogLevel.shout,
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
    LogLevel.shout,
  ],
};

/// HashMap with Levels
const Map<LogLevel, int> levelsAllocation = <LogLevel, int>{
  LogLevel.shout: 0,
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
