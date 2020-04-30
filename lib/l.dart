/// [L]ogger library
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
/// When there is no direct access to the terminal,
/// it works through print.
/// When it is not possible to get write access
/// to the working directory, the logs are not saved.
/// Do not log sensitive information.
library l;

import 'src/log_engine.dart' show L;

export 'src/log_engine.dart' show L;
export 'src/log_level.dart';
export 'src/log_message.dart';

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
/// When there is no direct access to the terminal,
/// it works through print.
/// When it is not possible to get write access
/// to the working directory, the logs are not saved.
/// Do not log sensitive information.
final L l = L();
