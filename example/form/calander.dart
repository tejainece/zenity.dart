library zenity.example.calander;

import 'dart:async';
import 'package:zenity/zenity.dart';

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