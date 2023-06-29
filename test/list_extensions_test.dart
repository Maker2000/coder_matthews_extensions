import 'package:test/test.dart';
import 'coder_matthews_extensions_test.dart';
import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';

void main() {
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
    allGirlsList =
        personList.where((element) => element.gender == Gender.female).toList();
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
    var result = testList.firstWhereOrNull((element) => element.age == 100);
    expect(result, null);
  });

  test('shouldAddBetweenElements', () {
    List<int> numbers = [1, 2, 3];
    var newNumbers = numbers.addBetween(0);
    var control = [1, 0, 2, 0, 3];
    expect(newNumbers, control);
  });
}
