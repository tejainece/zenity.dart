import 'dart:async';
import 'package:zenity/zenity.dart';

main() async {
  final bool reply = await Zenity.showQuestionMessage(
      title: 'Question', text: 'Dialogs for Dart!');
  print(reply);
}
