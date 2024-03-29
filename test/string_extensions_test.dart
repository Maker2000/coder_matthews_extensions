import 'package:test/test.dart';
import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';
import 'coder_matthews_extensions_test.dart';

void main() {
  final testerString = 'the Sky IS BluE.';
  setUp(() {
    testPerson = CoderPerson(name: 'John', age: 20, gender: Gender.male);
  });

  test('shouldCheckValidEmail', () {
    final hasValidEmail = testPerson.email.isEmail;
    expect(hasValidEmail, true);
  });

  test('shouldDisplaySentenceCase', () {
    final control = 'The sky is blue.';
    final test = testerString.sentenceCase;
    expect(test, control);
  });

  test('shouldDisplayTitleCase', () {
    final test = testerString.titleCase;
    final control = 'The Sky Is Blue.';
    expect(test, control);
  });

  test('shouldCheckIfNullOrEmpty', () {
    String? control = testerString;
    bool result = control.isNullOrEmpty;
    expect(result, false);
    control = '';
    result = control.isNullOrEmpty;
    expect(result, true);
    control = null;
    result = control.isNullOrEmpty;
    expect(result, true);

    control = testerString;
    result = control.isNotNullOrEmpty;
    expect(result, true);
    control = '';
    result = control.isNotNullOrEmpty;
    expect(result, false);
    control = null;
    result = control.isNotNullOrEmpty;
    expect(result, false);
  });

  test('shouldDisplayOnlyDigits', () {
    var number = '+1 (342) 342-2314';
    var control = '13423422314';
    var result = number.onlyNumbers;
    expect(result, control);
  });

  test('shouldFormatPhoneNumber', () {
    var number = '3423422314';
    var control = '(342) 342-2314';
    var result = number.toPhoneNumberString;
    expect(result, control);
  });

  test('shouldConvertStringToMap', () {
    var control = <String, dynamic>{'name': 'Tom', 'location': 'USA'};
    var testString = "{\"name\":\"Tom\",\"location\":\"USA\"}";
    var decodedJson = testString.toDecodedJson;
    expect(control, decodedJson);
  });

  test('shouldRemoveCharactersFromString', () {
    var control = 'Test String';
    var testString = "Testk StringkK";
    var decodedJson = testString.remove('k');
    expect(control, decodedJson);
  });

  test('shouldGetFileNameAndFileExtension', () {
    var filename = 'test.file.xml';
    var extensionControl = '.xml';
    var actualFileNameExtensionControl = 'test.file';
    expect(filename.fileExtension, extensionControl);
    expect(filename.actualFileName, actualFileNameExtensionControl);
  });

  test('shouldConvertStringToCases', () {
    var snakeCase = 'word_case';
    var pascalCase = 'WordCase';
    var camelCase = 'wordCase';
    expect(camelCase.camelCaseToSnakeCase, snakeCase);
    expect(camelCase.camelCaseToPascalCase, pascalCase);
    expect(snakeCase.snakeCaseToCamelCase, camelCase);
    expect(snakeCase.snakeCaseToPascalCase, pascalCase);
    expect(pascalCase.pascalCaseToCamelCase, camelCase);
    expect(pascalCase.pascalCaseToSnakeCase, snakeCase);
  });
}
