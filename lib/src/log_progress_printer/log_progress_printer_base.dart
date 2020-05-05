/// Progress printer
abstract class ProgressPrinterBase {
  /// Available feature
  bool get available;

  /// Get the number of columns of the terminal.
  int get columns;

  /// Reset progress bar
  void discard();

  /// Whether connected to a terminal that supports ANSI escape sequences.
  bool get supportsAnsiEscapes => false;

  /// Print progress to console
  void printLines(String header, String content, String footer, int width);
}
