## 5.0.0-pre.2 - 2024-01-20

### Changed

- **BREAKING:** Refactoring `LogMessage` and `LogMessageWithStackTrace` events

### Added

- Add `l.log` method
- Add `LogContext` for each log event

## 4.1.0-pre.1 - 2023-07-13

### Changed

- Add `overrideOutput` to options - allow to use custom message formatting and print handler.
  If returns `null` then the message will not be output to the console by default logger.
  You can use it to print to a file or to a database or for raw JSON output.

## 4.0.2 - 2023-06-30

### Changed

- Refactoring

## 4.0.1 - 2023-06-06

### Added

- Restore `LogMessage` and `LogMessageWithStackTrace` classes from JSON
- **BREAKING:** Date format in JSON is now serialized microseconds since epoch instead of seconds since epoch

## 4.0.0 - 2023-05-13

### Changed

- Dart 3.0.0 ready

## 3.2.0 - 2022-03-30

### Added

- 100% coverage

### Fixed

- [Minor bug](https://github.com/PlugFox/l/issues/20) with Stack Overflow exception in multiple zones without print handler

## 3.1.0 - 2021-11-15

### Added

- Add `printColors` in LogOptions

## 3.0.2+1 - 2021-11-01

### Changed

- Update changelog

## 3.0.2 - 2021-11-01

### Added

- Add `outputInRelease` in LogOptions

## 3.0.1 - 2021-03-28

### Added

- Export `LogMessageWithStackTrace`

### Changed

- Creating `LogMessageWithStackTrace` instead `LogMessage` only if `StackTrace` exist.

## 3.0.0 - 2021-03-27

### Changed

- Total refactoring
- Null safety support
- `capture` feature
- customization through zones
- Simplification

## 3.0.0-nullsafety.5 - 2021-03-24

### Fixed

- Use `print` when `stdout` is unavailable

## 3.0.0-nullsafety.4 - 2021-03-24

### Added

- Flutter example

### Fixed

- `print` with root zone at io

## 3.0.0-nullsafety.3 - 2021-03-24

### Added

- `capture` feature
- `handlePrint` feature
- `messageFormatting` feature

## 3.0.0-nullsafety.1 - 2021-03-11

### Added

- New badges

### Changed

- Non nullable by default
- Full refactoring
- Simplification

### Removed

- **BREAKING:** Remove progress feature
- **BREAKING:** Remove middleware function feature
- **BREAKING:** Store logs at txt file and indexed db feature

## 3.0.0-nullsafety.0 - 2021-02-19

### Changed

- Non nullable ready

## 2.0.0-dev - 2020-08-29

### Added

- Support multiline pretty output
- Three short form to access the instance of Logger
  - `L.instance`
  - `L.I`
  - `l`

### Changed

- refactoring and new lints (pedantic + effective dart)

### Removed

- Remove default factory L()

## 1.1.1 - 2020-05-14

- Fix terminal at Android Studio in Linux

## 1.1.0+3 - 2020-05-05

- Fix progress table in Readme

## 1.1.0+2 - 2020-05-05

- Upd readme

# 1.1.0+1 - 2020-05-05

- dartfmt

## 1.1.0 - 2020-05-05

- Add progress as p method
- Colorize output if supported

## 1.0.1 - 2020-04-01

- Made all prefixes uppercase

## 1.0.0 - 2020-04-30

- Add [wide] for display wide prefix entry

## 0.9.0 - 2020-04-30

- Add a middleware and stream
- Everything is documented

## 0.1.0 - 2020-04-30

- Add mobile support

## 0.0.1+1 - 2020-04-29

- Some cosmetic changes

## 0.0.1 - 2020-04-29

- Initial release with main functional
