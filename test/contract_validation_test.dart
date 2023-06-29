import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';
import 'package:test/test.dart';

void main() {
  void throwStringValidationContract(String? val) {
    if (val.isNullOrEmpty) {
      ValidationContract.requireNotNullOrEmpty(
          val, 'Error', 'This string is required to have a value');
    } else {
      ValidationContract.requireNullOrEmpty(
          val, 'Error', 'This string is required not to have a value');
    }
  }

  void throwValidationContract<T>(T? val) {
    if (val.isNull) {
      ValidationContract.requireNotNull(
          val, 'Error', 'This string is required to have a value');
    } else {
      ValidationContract.requireNull(
          val, 'Error', 'This string is required not to have a value');
    }
  }

  test('shouldValidateStringToNotBeNull', () {
    expect(() => throwStringValidationContract(null),
        throwsA(isA<AppException>()));
  });

  test('shouldValidateStringToBeNull', () {
    expect(() => throwStringValidationContract('value'),
        throwsA(isA<AppException>()));
  });

  test('shouldValidateObjectToNotBeNull', () {
    expect(() => throwValidationContract(null), throwsA(isA<AppException>()));
  });

  test('shouldValidateObjectToBeNull', () {
    expect(() => throwValidationContract({'key': 'value'}),
        throwsA(isA<AppException>()));
  });
}
