library zenity.src;

import 'package:meta/meta.dart';
import 'dart:async';
import 'dart:io';
import 'dart:collection';

part 'forms.dart';

/// Namespace to show Zenity dialogs
abstract class Zenity {
  /// Checks whether Zenity is installed and is in the path
  ///
  ///     await Zenity.exists? print('Exists!'): print('Doesn't exist!');
  static Future<bool> get exists async {
    try {
      await Process.run('zenity', ['--version']);
    } on ProcessException catch (e) {
      if (e.message == 'No such file or directory') return false;
      rethrow;
    }
    return true;
  }

  static Future<FormResult> readForm(Form form) async {
    final args = <String>[];

    args.add('--forms'); // Show form
    args.add('--title=${form.title}'); // Title of the window
    args.add('--text=${form.name}');
    args.add('--separator=,');
    args.add('--forms-date-format=%Y-%m-%d');

    for (Field field in form.fields) {
      args.add('--add-${field.type}=${field.label}');
    }

    ProcessResult results = await Process.run('zenity', args);

    if (results.exitCode < 0) {
      throw new Exception('Unexpected error!');
    }

    if (results.exitCode > 1) throw new Exception('Unhandled return status!');

    if (results.exitCode == 1) return null;

    return new FormResult.make(form, results.stdout);
  }

  static Future<String> readPassword(
      {String title, String text, int width, int height}) async {
    final args = <String>[];

    args.add('--password');
    args.add('--title=$title');
    args.add('--text=$text');
    if (width != null) {
      args.add('--width=$width');
    }
    if (height != null) {
      args.add('--height=$height');
    }

    ProcessResult results = await Process.run('zenity', args);

    if (results.exitCode < 0) {
      throw new Exception('Unexpected error!');
    }

    if (results.exitCode > 1) throw new Exception('Unhandled return status!');

    if (results.exitCode == 1) return null;

    return results.stdout;
  }

  static Future<UserPassword> readUsernamePassword(
      {String title, String text, int width, int height}) async {
    final args = <String>[];

    args.add('--password');
    args.add('--title=$title');
    args.add('--text=$text');
    args.add('--username');
    if (width != null) {
      args.add('--width=$width');
    }
    if (height != null) {
      args.add('--height=$height');
    }

    ProcessResult results = await Process.run('zenity', args);

    if (results.exitCode < 0) {
      throw new Exception('Unexpected error!');
    }

    if (results.exitCode > 1) throw new Exception('Unhandled return status!');

    if (results.exitCode == 1) return null;

    final List<String> parts = (results.stdout as String).split('|');

    return new UserPassword(parts[0], parts[1]);
  }

  /// Shows information dialog
  static Future showInfoMessage(
      {String title, String text, int width, int height}) async {
    final args = <String>[];

    args.add('--info');
    args.add('--title=$title');
    args.add('--text=$text');
    if (width != null) {
      args.add('--width=$width');
    }
    if (height != null) {
      args.add('--height=$height');
    }

    ProcessResult results = await Process.run('zenity', args);

    if (results.exitCode < 0) {
      throw new Exception('Unexpected error!');
    }

    if (results.exitCode > 1) throw new Exception('Unhandled return status!');
  }

  static Future showErrorMessage(
      {String title, String text, int width, int height}) async {
    final args = <String>[];

    args.add('--error');
    args.add('--title=$title');
    args.add('--text=$text');
    if (width != null) {
      args.add('--width=$width');
    }
    if (height != null) {
      args.add('--height=$height');
    }

    ProcessResult results = await Process.run('zenity', args);

    if (results.exitCode < 0) {
      throw new Exception('Unexpected error!');
    }

    if (results.exitCode > 1) throw new Exception('Unhandled return status!');

    if (results.exitCode == 1) return null;
  }

  static Future showWarningMessage(
      {String title, String text, int width, int height}) async {
    final args = <String>[];

    args.add('--warning');
    args.add('--title=$title');
    args.add('--text=$text');
    if (width != null) {
      args.add('--width=$width');
    }
    if (height != null) {
      args.add('--height=$height');
    }

    ProcessResult results = await Process.run('zenity', args);

    if (results.exitCode < 0) {
      throw new Exception('Unexpected error!');
    }

    if (results.exitCode > 1) throw new Exception('Unhandled return status!');

    if (results.exitCode == 1) return null;
  }

  static Future<bool> showQuestionMessage(
      {String title, String text, int width, int height}) async {
    final args = <String>[];

    args.add('--question');
    args.add('--title=$title');
    args.add('--text=$text');
    if (width != null) {
      args.add('--width=$width');
    }
    if (height != null) {
      args.add('--height=$height');
    }

    ProcessResult results = await Process.run('zenity', args);

    if (results.exitCode < 0) {
      throw new Exception('Unexpected error!');
    }

    if (results.exitCode > 1) throw new Exception('Unhandled return status!');

    return results.exitCode == 0;
  }

  static Future<List<String>> selectFiles(
      {String title,
      String text,
      int width,
      int height,
      String filename,
      bool multiple: false,
      bool directory: false,
      bool save: false,
      String seprarator: '|'}) async {
    final args = <String>[];

    args.add('--file-selection');
    args.add('--title=$title');
    args.add('--text=$text');
    if (width != null) args.add('--width=$width');
    if (height != null) args.add('--height=$height');
    if (filename != null) args.add('--filename=$filename');
    if (multiple) args.add('--multiple');
    if (directory) args.add('--directory');
    if (save) args.add('--save');
    if (seprarator != '|') args.add('--separator=$seprarator');

    ProcessResult results = await Process.run('zenity', args);

    if (results.exitCode < 0) {
      throw new Exception('Unexpected error!');
    }

    if (results.exitCode > 1) throw new Exception('Unhandled return status!');

    if (results.exitCode == 1) return null;

    return (results.stdout as String).split(seprarator);
  }

  static Future<bool> showProgress(
      {String title,
      String text,
      int width,
      int height,
      int initialPercentage: 0,
      bool autoClose: false,
      bool pulsate: false,
      Stream<int> progress}) async {
    final args = <String>[];

    args.add('--progress');
    args.add('--title=$title');
    args.add('--text=$text');
    if (width != null) args.add('--width=$width');
    if (height != null) args.add('--height=$height');
    if (initialPercentage != 0) args.add('--percentage=$initialPercentage');
    if (autoClose) args.add('--auto-close');
    if (pulsate) args.add('--pulsate');

    final Process process = await Process.start('zenity', args);

    int exitCode;
    StreamSubscription<int> sub;
    sub = progress.listen((int prog) {
      if (exitCode != null) {
        sub.cancel();
        return;
      }
      process.stdin.writeln(prog);
    });

    exitCode = await process.exitCode;
    sub.cancel();

    if (exitCode < 0) {
      throw new Exception('Unexpected error!');
    }

    if (exitCode > 1) throw new Exception('Unhandled return status!');

    return exitCode == 0;
  }
}

class UserPassword {
  final String username;

  final String password;

  UserPassword(this.username, this.password);

  String toString() => 'User: $username Password: $password';
}
