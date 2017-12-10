part of zenity.src;

/// Model for form results
class FormResult {
  /// Field labels
  final UnmodifiableListView<String> fields;

  /// Field values
  final UnmodifiableListView<String> values;

  /// As label:value map
  final UnmodifiableMapView<String, dynamic> asMap;

  FormResult(this.fields, this.values, this.asMap);

  /// Constructs [FormResult] from given [Form] and result string
  factory FormResult.make(Form form, String result) {
    final fields = form.fields.map((f) => f.label).toList();
    final values = result.split(form.separator).toList();

    if (fields.length != values.length)
      throw new Exception('One or more of the values contain separator!');

    final map = <String, dynamic>{};

    for (int i = 0; i < fields.length; i++) {
      if (form.fields[i] is CalendarField) {
        try {
          final List<int> parts =
              values[i].split('-').map((f) => int.parse(f)).toList();
          map[fields[i]] = new DateTime(parts[0], parts[1], parts[2]);
        } catch (e) {
          print(e);
          print(values[i]);
          map[fields[i]] = null;
        }
      } else if (form.fields[i] is IntField) {
        try {
          map[fields[i]] = int.parse(values[i]);
        } catch (e) {
          map[fields[i]] = null;
        }
      } else if (form.fields[i] is NumField) {
        try {
          map[fields[i]] = num.parse(values[i]);
        } catch (e) {
          map[fields[i]] = null;
        }
      } else if (form.fields[i] is DoubleField) {
        try {
          map[fields[i]] = double.parse(values[i]);
        } catch (e) {
          map[fields[i]] = null;
        }
      } else {
        map[fields[i]] = values[i];
      }
    }

    return new FormResult(
        new UnmodifiableListView<String>(fields),
        new UnmodifiableListView<String>(values),
        new UnmodifiableMapView<String, dynamic>(map));
  }

  String toString() => asMap.toString();
}

/// Base class for a field
abstract class Field {
  /// Label of the field
  String get label;

  /// Type of the field
  String get type;
}

/// Text field
class TextField implements Field {
  final String label;

  final String type = 'entry';

  const TextField(this.label);
}

/// Integer field
class IntField implements Field {
  final String label;

  final String type = 'entry';

  const IntField(this.label);
}

/// Double precision floating point field
class DoubleField implements Field {
  final String label;

  final String type = 'entry';

  const DoubleField(this.label);
}

/// Number field
class NumField implements Field {
  final String label;

  final String type = 'entry';

  const NumField(this.label);
}

/// Password field
class PasswordField implements Field {
  final String label;

  final String type = 'password';

  const PasswordField(this.label);
}

/// Calender field
class CalendarField implements Field {
  final String label;

  final String type = 'calendar';

  const CalendarField(this.label);
}

/// Form field
///
///     final FormResult result =
///         await new Form(title: 'Test', name: 'User info', fields: [
///       new TextField('First name:'),
///       new TextField('Last name:'),
///       new PasswordField('Password'),
///       new CalendarField('DoB')
///     ]).read;
///     print(result);
class Form {
  /// Title of the window
  final String title;

  /// Name of the form
  final String name;

  /// Fields
  final List<Field> fields;

  final String separator;

  const Form(
      {@required this.title,
      this.name: 'Form',
      @required this.fields: const <Field>[],
      this.separator: ','});

  /// Shows the form and returns the result
  Future<FormResult> get read => Zenity.readForm(this);
}
