import 'package:zenity/zenity.dart';

main() async {
  await Zenity.showWarningMessage(title: 'Warning', text: 'Dialogs for Dart!');
}