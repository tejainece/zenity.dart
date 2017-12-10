import 'package:zenity/zenity.dart';

main() async {
  final List<String> files = await Zenity.selectFiles();
  print(files);
}