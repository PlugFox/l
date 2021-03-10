/*
 *            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *                    Version 2, December 2004
 *
 * Copyright (C) 2021 Plague Fox <plugfox@gmail.com>
 *
 * Everyone is permitted to copy and distribute verbatim or modified
 * copies of this license document, and changing it is allowed as long
 * as the name is changed.
 *
 *            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 *
 *  0. You just DO WHAT THE FUCK YOU WANT TO.
 *
 */

library l;

import 'src/inner_logger.dart' show InnerLoggerImpl;
import 'src/l.dart';

export 'src/l.dart';
export 'src/log_level.dart';
export 'src/log_message.dart';

/// [L]ogger
///
/// Cross-platform html/io Logger with simple API.
/// No need to create an object. Just import and use.
/// Simple and w/o boilerplate.
/// Work with native console.
///
/// When there is no direct access to the terminal,
/// it works through print.
///
/// ### Key features
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
/// ### Integration capabilities
///
/// | Method      | Description                       |
/// |-------------|-----------------------------------|
/// | [listen]    | Broadcast stream receiving logs.  |
///
/// **!!! PLEASE, DO NOT LOG SENSITIVE INFORMATION !!!**
///
final L l = InnerLoggerImpl();

/// TODO: продумать конфиг
/// TODO: обновить описание
/// TODO: обновить ченджлог
