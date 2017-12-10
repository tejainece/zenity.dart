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
