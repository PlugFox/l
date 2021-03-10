# [L]ogger  
  
![](https://github.com/PlugFox/l/raw/master/.img/l.png)  
  
[![GitHub stars](https://img.shields.io/github/stars/PlugFox/l?style=social)](https://github.com/PlugFox/l/)
[![Actions Status](https://github.com/PlugFox/l/workflows/Logger/badge.svg)](https://github.com/PlugFox/l/actions)
[![Pub](https://img.shields.io/pub/v/l.svg)](https://pub.dev/packages/l)
[![Likes](https://img.shields.io/badge/dynamic/json?color=blue&label=likes&query=likes&url=http://www.pubscore.gq/likes?package=l&style=flat-square&cacheSeconds=90000)](https://pub.dev/packages/l)
[![Health](https://img.shields.io/badge/dynamic/json?color=blue&label=health&query=pub_points&url=http://www.pubscore.gq/pub-points?package=l&style=flat-square&cacheSeconds=90000)](https://pub.dev/packages/l/score)
[![License: WTFPL](https://img.shields.io/badge/License-WTFPL-brightgreen.svg)](https://en.wikipedia.org/wiki/WTFPL)
[![Code size](https://img.shields.io/github/languages/code-size/plugfox/l?logo=github&logoColor=white)](https://github.com/plugfox/l)
[![effective_dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)
  
  
## About  
Cross-platform html/io `[L]`ogger with simple API.  
No need to create an logger object. Just import and use. Simple and w/o boilerplate.  
Work with native console and can store logs in txt files (io) and indexedDB (web).  
You can change verbose level and resume/pause log queue, also you can clear console.  
  
  
![](https://github.com/PlugFox/l/raw/master/.img/l.gif)  
  
---
  
## Core API  
  
### Key features  
  
| Method          | Description                          |
|-----------------|--------------------------------------|
| **s**           | A shout is always displayed          |
| **v**           | Regular message with verbose level 1 |
| **e**           | Error message with verbose level 1   |
| **vv**          | Regular message with verbose level 2 |
| **w**           | Warning message with verbose level 2 |
| **vvv**         | Regular message with verbose level 3 |
| **i** or **<**  | Inform message with verbose level 3  |
| **vvvv**        | Regular message with verbose level 4 |
| **d** or **<<** | Debug message with verbose level 4   |
| **vvvvv**       | Regular message with verbose level 5 |
| **vvvvvv**      | Regular message with verbose level 6 |
  
```dart
l.s('shout me');
l.e('error msg');
l.w('warning msg');
l.i('info msg');
l < 'alt info msg';
l.d('debug msg');
l << 'alt debug msg';
l.v('verbose lvl #1');
l.vv('verbose lvl #2');
l.vvv('verbose lvl #3');
l.vvvv('verbose lvl #4');
l.vvvvv('verbose lvl #5');
l.vvvvvv('verbose lvl #6');
~l;
```  
  
  
### Setup and management  
  
| Method         | Description                                              |
|----------------|----------------------------------------------------------|
| **lvl**        | Limiting output level (default 3 in release, 6 in debug) |
| **store**      | Set to true to save logs (default is false)              |
| **wide**       | Display wide prefix entry (default is false)             |
| **pause**      | Pause for message queue                                  |
| **resume**     | Continued after a pause                                  |
| **clear**      | Console cleaning (if a terminal is connected)            |
| **length**     | Logger max line length                                   |
  
```dart
l.lvl = 4;
l.store = true;
l.wide = false;
l.lineLength = 120;
l.pause();
l.resume();
l.clear();
```  
  
  
### Progress  
  
Only works in io environments with a connected terminal.  
If it is impossible to output - ignored.  
Pauses the output of the remaining logs, do not forget to use the "resume".  
  
| Method     | Description                       |
|------------|-----------------------------------|
| **p**      | Displays a progress bar           |
| **resume** | Continued after progress finished |
  
```dart
Stream<int>.fromIterable(List<int>.generate(101, (int v) => v))
    .asyncMap<int>((int v) =>
        Future<int>.delayed(const Duration(milliseconds: 25), () => v))
    .forEach((int v) => l.p(
        percent: v,
        header: '{{ HEADER $v }}',
        data: '{{ data $v% }}',
        footer: '{{ footer $v }}',))
      ..whenComplete(l.resume); // Must use 'resume'
```  

Output:
```
                {{ HEADER 21 }}
[========>       {{ data 21% }}                ]
                                {{ footer 21 }}
```
  
  
### Integration capabilities  
  
| Method        | Description                                |
|---------------|--------------------------------------------|
| **stream**    | Broadcast stream instantly receiving logs. |
| **mw**        | Middleware queue with functions            |
  
```dart
// Broadcast stream instantly receiving logs.
l.stream.forEach((LogMessage log) => print('* ${log.level}'));

// Middleware queue, functions are called 
// at the time of log processing
// and block further until complete execution
l.mw.addAll(<Future<void> Function(LogMessage)>[
  (LogMessage log) async {print('# ${log.date}');},
  (LogMessage log) async {print('# ${log.message}');},
]);
```  
  
  
---
  
## Limitations  
  
* When there is no direct access to the terminal, it works through print.  
* When it is not possible to get write access to the working directory, the logs are not saved.  
* Do not log sensitive information.  
  
  
---  
  
## Changelog  
  
Refer to the [Changelog](https://github.com/plugfox/platform_info/blob/master/CHANGELOG.md) to get all release notes.  
  
  
---
  
## Maintainers  
  
[Plague Fox](https://plugfox.dev)  
  
  
---
  
## License  
  
[WTFPL](https://github.com/plugfox/platform_info/blob/master/LICENSE)  
  
  
---
  
## Tags  
  
logger, log, logs, logging, logging-library, cross-platform, io, html  
  
  