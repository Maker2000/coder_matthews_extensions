import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';
import 'package:test/test.dart';

late List<CoderPerson> personList, allGirlsList;
late CoderPerson testPerson;
late List<double> valueList;
void main() {
  group('List Extension Tests', () {
    setUp(() {
      personList = [
        CoderPerson(name: "Jane", age: 16, gender: Gender.female),
        CoderPerson(name: 'Bob', age: 20, gender: Gender.male),
        CoderPerson(name: 'King', age: 56, gender: Gender.male),
        CoderPerson(name: "Joane", age: 18, gender: Gender.female),
        CoderPerson(name: "Katy", age: 22, gender: Gender.female),
        CoderPerson(name: 'George', age: 17, gender: Gender.male),
        CoderPerson(name: 'Bruce', age: 47, gender: Gender.male),
      ];
      allGirlsList = personList
          .where((element) => element.gender == Gender.female)
          .toList();
      valueList = <double>[1.3, 1, 2.7];
    });

    test('shouldGetMaxValue', () {
      final max = valueList.maxValue((element) => element);
      expect(max, 2.7);
      final oldestPerson = personList.maxElement((element) => element.age);
      expect(oldestPerson.age, 56);
    });

    test('shouldGetMinValue', () {
      final min = valueList.minValue((element) => element);
      expect(min, 1);
      final youngestPerson = personList.minElement((element) => element.age);
      expect(youngestPerson.age, 16);
    });

    test('shouldGroupBy', () {
      final group = personList.groupBy((e) => e.gender);
      expect(group[Gender.male]?.length, 4);
      expect(group[Gender.female]?.length, 3);
    });

    // test('shouldCheckIfListContainsElement', () {
    //   bool result = personList.containsElement(
    //       () => CoderPerson(name: "Jane", age: 16, gender: Gender.female));
    //   expect(result, true);

    //   result = personList.containsElement(
    //       () => CoderPerson(name: "Jane", age: 1, gender: Gender.female));
    //   expect(result, false);
    // });

    test('shouldCheckIfAllElementsHasProperty', () {
      bool allGirlsInList =
          personList.compoundAnd((e) => e.gender == Gender.female);
      expect(allGirlsInList, false);
      allGirlsInList =
          allGirlsList.compoundAnd((e) => e.gender == Gender.female);
      expect(allGirlsInList, true);
    });

    test('shouldCheckIfSomeElementsHasProperty', () {
      bool someFemalesInList =
          personList.compoundOr((e) => e.gender == Gender.male);
      expect(someFemalesInList, true);
      bool someMalesInList =
          personList.compoundOr((e) => e.gender == Gender.male);
      expect(someMalesInList, true);
    });

    test('shouldRemoveNullsFromList', () {
      List<CoderPerson?> testList = [];
      testList.addAll(List.of(personList));
      testList.add(null);
      testList.add(null);
      var newTestList = testList.removeNulls;
      expect(newTestList.length, personList.length);
    });

    test('shouldSumAllValuesInList', () {
      final sumOfAges = personList.sum((element) => element.age);
      expect(sumOfAges, 196);
    });

    test('shouldGetAverageValuesInList', () {
      final sumOfAges = personList.average((element) => element.age);
      expect(sumOfAges, 28);
    });

    test('shouldReturnNull', () {
      List<CoderPerson> testList = [];
      testList.addAll(List.of(personList));
      var result = testList.firstOrNull((element) => element.age == 100);
      expect(result, null);
    });
  });

  group('String Extension Tests', () {
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
  });

  group('Map Extension Tests', () {
    test('shouldRemoveNullsFromMap', () {
      var testMap = <String, dynamic>{
        'name': 'Tom',
        'age': null,
        'location': 'USA'
      };
      var control = <String, dynamic>{'name': 'Tom', 'location': 'USA'};
      var newMap = testMap.removeNulls;
      expect(control.entries.length, newMap.entries.length);
    });
  });
  group('Enum Extensions', () {
    test("shouldConvertToTitle", () {
      var testingEnum = TestingEnum.longTitle;
      var control = 'Long Title';
      expect(control, testingEnum.titleCase);
    });
  });
}
