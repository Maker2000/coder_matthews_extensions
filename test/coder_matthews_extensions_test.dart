import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';
import 'package:test/test.dart';

import 'test_data.dart';

void main() {
  group('A group of tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('Max Test', () {
      final valueList = <double>[1.3, 1, 2.7];
      final max = valueList.maxValue((element) => element);
      expect(max, 2.7);
      final personList = [
        Person("Jane", 16),
        Person('Bob', 20),
        Person('King', 56)
      ];
      final oldestPerson = personList.maxElement((element) => element.age);
      expect(oldestPerson.age, 56);
    });

    test('Min Test', () {
      final valueList = <double>[1.3, 1, 2.7];
      final max = valueList.minValue((element) => element);
      expect(max, 1);
      final personList = [
        Person('Bob', 20),
        Person("Jane", 16),
        Person('King', 56)
      ];
      final oldestPerson = personList.minElement((element) => element.age);
      expect(oldestPerson.age, 16);
    });
  });
}
