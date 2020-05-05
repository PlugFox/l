import 'log_progress_printer/log_progress_printer_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'log_progress_printer/log_progress_printer_io.dart';

/// Progress bar
abstract class Progress {
  static final ProgressPrinter _printer = getProgressPrinter();
  Progress._();

  /// Progress bar
  ///
  /// percent is int in range 0..100
  ///
  /// ```
  ///       {{header}}
  /// [======{{data}}=>   ]
  ///              {{footer}}
  /// ```
  ///
  static void update(
      {String header, String data, String footer, int percent = 0}) {
    if (!_printer.available) return;
    percent = (percent ?? percent ?? 0).clamp(0, 100).toInt();
    int width = _printer.columns.clamp(7, 80).toInt();
    _printer.printLines(
      _buildHeader(header, width),
      _buildProgressBar(percent, data, width),
      _buildFooter(footer, width),
      width,
    );
  }

  /// Reset progress bar
  static void discard() =>
    _printer.discard();

  static String _buildHeader(String header, int width) {
    if (header is! String) return null;
    if (header.length > width) {
      return header.substring(0, width - 3) + '...';
    } else if (header.length == width) {
      return header;
    }
    header = ' ' * ((width - header.length) ~/ 2) + header;
    header = header.padRight(width, ' ');
    if (_printer.supportsAnsiEscapes) {
      return '\x1B[1m' '\x1B[34m' + header + '\x1B[0m' '\x1B[0m';
    } else {
      return header;
    }
  }

  static String _buildProgressBar(int percent, String data, int width) {
    List<String> progressBar = List<String>(width);
    progressBar.first = '[';
    progressBar.last = ']';
    int filled = percent * (width - 2) ~/ 100;
    for (int idx = 1; idx <= filled; idx++) {
      if (idx == filled && percent != 100) {
        progressBar[idx] = '>';
      } else {
        progressBar[idx] = '=';
      }
    }
    if (data is String) {
      data = data.replaceAll('\n', ' ');
      data = data.length > (width - 4)
          ? data.substring(0, width - 5) + '...'
          : ' ' + data + ' ';
      int dataLength = data.length;
      int dataPadding = (width - dataLength) ~/ 2;
      for (int idx = 0; idx < dataLength; idx++) {
        progressBar[idx + dataPadding] = data[idx];
      }
    }
    if (_printer.supportsAnsiEscapes) {
      return '\x1B[1m' '\x1B[47m' '\x1B[45m' +
          progressBar.map((String v) => v is String ? v : ' ').join() +
          '\x1B[0m' '\x1B[0m' '\x1B[0m';
    } else {
      return progressBar.map((String v) => v is String ? v : ' ').join();
    }
  }

  static String _buildFooter(String footer, int width) {
    if (footer is! String) return null;
    if (footer.length > width) {
      return footer.substring(0, width - 3) + '...';
    } else if (footer.length == width) {
      return footer;
    }
    if (_printer.supportsAnsiEscapes) {
      return '\x1B[34m' + footer.padLeft(width, ' ') + '\x1B[0m';
    } else {
      return footer.padLeft(width, ' ');
    }
  }
}
