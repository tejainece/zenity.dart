import 'package:zenity/zenity.dart';

main() async {
  await Zenity.showInfoMessage(
      title: 'Information',
      text: 'Dialogs for Dart!');
}