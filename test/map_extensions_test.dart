import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';
import 'package:test/test.dart';

void main() {
  test('shouldRemoveNullsFromMap', () {
    var testMap = <String, dynamic>{'name': 'Tom', 'age': null, 'location': 'USA'};
    var control = <String, dynamic>{'name': 'Tom', 'location': 'USA'};
    var newMap = testMap.removeNulls;
    expect(control.entries.length, newMap.entries.length);
  });

  test('shouldConvertMapToEncodedJson', () {
    var testMap = <String, dynamic>{'name': 'Tom', 'location': 'USA'};
    var control = "{\"name\":\"Tom\",\"location\":\"USA\"}";
    var encodedString = testMap.toJsonEncodedString;
    expect(control, encodedString);
  });
}
