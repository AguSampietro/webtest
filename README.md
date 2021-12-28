# webtest
 First flutter web.


## freezed

### 1 - create a file

example my_class.dart

### 2 - create the class

```` 
```
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_class.freezed.dart'; // Important!!
part 'my_class.g.dart'; // Important!!

@freezed
class MyClass with _$MyClass {
  MyClass._();

  factory MyClass({
    String? id,
    String? name,
  }) = _MyClass;

  factory MyClass.fromJson(Map<String, dynamic> json) => _$MyClassFromJson(json);
}
```
````

### 3 - command
Run the following command and make sure the ```.freezed.dart``` and ```.g.dart``` files are created.

```$ flutter packages pub run build_runner build --delete-conflicting-outputs```
