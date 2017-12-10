import 'package:zenity/zenity.dart';

main() async {
  print(await Zenity.readUsernamePassword());
}