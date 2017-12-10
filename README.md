# zenity

Desktop UI library to show simple dialog boxes and forms. Uses Zenity under-the-hood.  

The following dialogs are supported:

+ Message
    + Info
    + Error
    + Question
    + Warning
+ Form with following fields
    + Text
    + Int
    + Double
    + Num
    + Password
    + DateTime
+ File selection
+ Password
+ Username:Password

# Examples

## Forms

```dart
main() async {
  final FormResult result =
  await new Form(title: 'Form example', name: 'User info', fields: [
    new TextField('First name:'),
    new TextField('Last name:'),
    new PasswordField('Password'),
    new CalendarField('DoB')
  ]).read;
  print(result);
}
```

Returns the form values are result:  

> {First name:: Teja, Last name:: Gudapati, Password: 1234as, DoB: 2017-12-11 00:00:00.000}

![Form dialog](https://raw.githubusercontent.com/tejainece/zenity.dart/master/docs/screenshots/form.png)

## Message

### Info

```dart
main() async {
  await Zenity.showInfoMessage(
      title: 'Information',
      text: 'Dialogs for Dart!');
}
```

![Info message dialog](https://raw.githubusercontent.com/tejainece/zenity.dart/master/docs/screenshots/info_message.png)

### Question

```dart
main() async {
  final bool reply = await Zenity.showQuestionMessage(
      title: 'Question', text: 'Dialogs for Dart!');
  print(reply);
}
```

![Question message dialog](https://raw.githubusercontent.com/tejainece/zenity.dart/master/docs/screenshots/question_message.png)

### Warning

```dart
main() async {
  await Zenity.showWarningMessage(title: 'Warning', text: 'Dialogs for Dart!');
}
```

### Error

```dart
main() async {
  await Zenity.showErrorMessage(title: 'Error', text: 'Dialogs for Dart!');
}
```

## Progress

```dart
import 'dart:async';
import 'package:zenity/zenity.dart';

Stream<int> get progress async* {
  for (int i = 0; i < 5; i++) {
    await new Future.delayed(new Duration(seconds: 2));
    yield await (i + 1) * (100 ~/ 5);
  }
}

main() async {
  await Zenity.showProgress(
      title: 'Progress', text: 'Loading...', progress: progress);
}
```

![Progress dialog](https://raw.githubusercontent.com/tejainece/zenity.dart/master/docs/screenshots/progress.png)

## Password

```dart
import 'package:zenity/zenity.dart';

main() async {
  print(await Zenity.readPassword());
}
```

![Password dialog](https://raw.githubusercontent.com/tejainece/zenity.dart/master/docs/screenshots/password.png)

## Select file

```dart
import 'package:zenity/zenity.dart';

main() async {
  final List<String> files = await Zenity.selectFiles();
  print(files);
}
```

![Select file dialog](https://raw.githubusercontent.com/tejainece/zenity.dart/master/docs/screenshots/select_file.png)
