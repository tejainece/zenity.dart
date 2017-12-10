import 'package:zenity/zenity.dart';

main() async {
  await Zenity.showErrorMessage(title: 'Error', text: 'Dialogs for Dart!');
}