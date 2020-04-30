[![Pub](https://img.shields.io/pub/v/l.svg)](https://pub.dartlang.org/packages/l)  
  
![](https://github.com/PlugFox/l/raw/master/.img/l.png)  
  
### About  
Cross-platform html/io `[L]`ogger with simple API.  
No need to create an object. Just import and use. Simple and w/o boilerplate.  
Work with native console and can store logs in txt files (io) and indexedDB (web).  
You can change verbose level and resume/pause log queue, also you can clear console.  
  
  
  
---
  
### Core API  
  
##### Key features  
  
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
  
  
##### Setup and management  
  
| Method        | Description                                              |
|---------------|----------------------------------------------------------|
| **lvl**       | Limiting output level (default 3 in release, 6 in debug) |
| **store**     | Set to true to save logs (default is false)              |
| **wide**      | Display wide prefix entry (default is false)             |
| **pause**     | Pause for message queue                                  |
| **resume**    | Continued after a pause                                  |
| **clear**     | Console cleaning (if a terminal is connected)            |
  
```dart
l.lvl = 4;
l.store = true;
l.wide = false;
l.pause();
l.resume();
l.clear();
```  
  
  
##### Integration capabilities  
  
| Method        | Description                                |
|---------------|--------------------------------------------|
| **stream**    | Broadcast stream instantly receiving logs. |
| **mw**        | Middleware queue with functions            |
```dart
// Broadcast stream instantly receiving logs.
l.stream.forEach((LogMessage log) => print('* ${log.level}'));

// Middleware queue, functions are called 
// at the time of log processing
l.mw.addAll(<Future<void> Function(LogMessage)>[
  (LogMessage log) async {print('# ${log.date}');},
  (LogMessage log) async {print('# ${log.message}');},
]);
```  
  
  
---
  
### Limitations  
  
* When there is no direct access to the terminal, it works through print.  
* When it is not possible to get write access to the working directory, the logs are not saved.  
* Do not log sensitive information.  
  
    
  