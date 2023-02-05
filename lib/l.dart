/*
 * MIT License
 *
 * Copyright (c) 2023 Matiunin Mikhail <plugfox@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */

library l;

import 'src/inner_logger.dart' show InnerLoggerImpl;
import 'src/logger.dart';

export 'src/log_level.dart';
export 'src/log_message.dart';
export 'src/log_message_with_stack_trace.dart';
export 'src/log_options.dart';
export 'src/logger.dart';

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
/// |     Method     | Description                          |
/// |----------------|--------------------------------------|
/// | [s]            | A shout is always displayed          |
/// | [v1], [v]      | Regular message with verbose level 1 |
/// | [e]            | Error message with verbose level 1   |
/// | [v2], [vv]     | Regular message with verbose level 2 |
/// | [w]            | Warning message with verbose level 2 |
/// | [v3], [vvv]    | Regular message with verbose level 3 |
/// | [i], [<]       | Inform message with verbose level 3  |
/// | [v4], [vvvv]   | Regular message with verbose level 4 |
/// | [d], [<<]      | Debug message with verbose level 4   |
/// | [v5], [vvvvv]  | Regular message with verbose level 5 |
/// | [v6], [vvvvvv] | Regular message with verbose level 6 |
///
///
/// ### Integration capabilities
///
/// |     Method     | Description                       |
/// |----------------|-----------------------------------|
/// |    [listen]    | Broadcast stream receiving logs.  |
///
/// **!!! PLEASE, DO NOT LOG SENSITIVE INFORMATION !!!**
///
final L l = InnerLoggerImpl();
