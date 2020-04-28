# [L]ogger  
  
  
### About  
  
  
  
---
  
### Example:  
  
```dart
import 'package:l/l.dart';

void main() async {
  l.lvl = 6;
  l.v('max verbose');
  l.e('error');
  l < 'info';
  l.pause();
  l << 'debug';
  l.w('warning');
  l.vvvv('verbose #4');
  l.vvvvvv('min verbose');
  l.resume();
  l.close();
}
```  
  
  