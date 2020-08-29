import 'dart:io' as io;
import 'log_progress_printer_base.dart';

///
ProgressPrinter getProgressPrinter() => ProgressPrinter();

///
class ProgressPrinter implements ProgressPrinterBase {
  @override
  bool get available => _hasTerminal;

  @override
  int get columns => _console.terminalColumns ?? 80;

  @override
  bool supportsAnsiEscapes = false;

  bool _hasTerminal = false;
  io.Stdout get _console => io.stdout;
  int _prevWidth = 0;
  int _prevHeight = 0;

  /// Printer
  ProgressPrinter() {
    _hasTerminal = io.stdout.hasTerminal;
    if (_hasTerminal) {
      supportsAnsiEscapes = _console.supportsAnsiEscapes;
    }
  }

  @override
  void discard() {
    _prevWidth = 0;
    _prevHeight = 0;
  }

  @override
  void printLines(String header, String content, String footer, int width) {
    if (!available) return;

    if (supportsAnsiEscapes) {
      if (_prevWidth is int && _prevWidth > 0) {
        _console.write('\x1B[${_prevWidth}D'); // move left
      }
      if (_prevHeight is int && _prevHeight > 0) {
        _console.write('\x1B[${_prevHeight}A'); // move up
      }
    } else {
      _console.flush();
    }

    final strings = <String>[
      ...?header?.split('\n'),
      content,
      ...?footer?.split('\n'),
    ];
    _prevHeight = strings.length;
    _prevWidth = width;
    strings.forEach(_console.writeln);
  }
}
