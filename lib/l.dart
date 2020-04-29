/// [L]ogger library
library l;

import 'src/log_engine.dart';

/// [L]ogger
///
/// Verbose levels:
///  * Release:
///    + 1 - v, e
///    + 2 - vv, w
///    + 3 - vvv, i
///  * Debug:
///    + 4 - vvvv, d
///    + 5 - vvvvv
///    + 6 - vvvvvv
///
/// !!! Do not log sensitive information !!!
final L l = L();
