import 'dart:async';

import 'package:test/test.dart';
import 'coder_matthews_extensions_test.dart';
import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';

void main() {
  setUp(() {
    personList = [
      CoderPerson(name: "Jane", age: 16, gender: Gender.female),
      CoderPerson(name: "Bobbet", age: 16, gender: Gender.female),
      CoderPerson(name: "Xanders", age: 16, gender: Gender.male),
      CoderPerson(name: 'Bob', age: 20, gender: Gender.male),
      CoderPerson(name: 'King', age: 56, gender: Gender.male),
      CoderPerson(name: "Joane", age: 18, gender: Gender.female),
      CoderPerson(name: "Katy", age: 22, gender: Gender.female),
      CoderPerson(name: 'George', age: 17, gender: Gender.male),
      CoderPerson(name: 'Bruce', age: 47, gender: Gender.male),
    ];
    allGirlsList = personList.where((element) => element.gender == Gender.female).toList();
    valueList = <double>[1.3, 1, 2.7];
  });

  test('shouldGetMaxValue', () {
    final max = valueList.max((element) => element);
    expect(max, 2.7);
    final oldestPerson = personList.max((element) => element.age);
    expect(oldestPerson?.age, 56);
  });

  test('shouldGetMinValue', () {
    final min = valueList.min((element) => element);
    expect(min, 1);
    final youngestPerson = personList.min((element) => element.age);
    expect(youngestPerson?.age, 16);
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

  test('shouldMapAsync', () async {
    Future<int> returnAsyncNumber(int number) async {
      await Future.delayed(Duration(seconds: 5));
      return number;
    }

    var counter = Stopwatch();

    List<int> asyncNumbers = [1, 2, 3];
    counter.start();
    var syncNumbers = await asyncNumbers.mapAsync((element) => returnAsyncNumber(element), 5);
    var control = [1, 2, 3];
    counter.stop();
    // check that the parallelisms worked
    // var time = counter.elapsed;
    expect(syncNumbers, control);
  });

  test('shouldExpandAsync', () async {
    Future<List<int>> returnAsyncList(int number) async {
      await Future.delayed(Duration(seconds: 5));
      return [number, number];
    }

    var counter = Stopwatch();
    List<int> asyncNumbers = [1, 2, 3];

    var syncNumbers = await asyncNumbers.expandAsync((element) => returnAsyncList(element), 5).toListAsync();
    var control = [1, 1, 2, 2, 3, 3];

    counter.start();
    counter.stop();
    // check that the parallelisms worked
    // var time = counter.elapsed;

    expect(syncNumbers, control);
  });
  test('shouldIntersectLists', () {
    var intesectPersonList = [
      CoderPerson(name: "Jane", age: 16, gender: Gender.female),
      CoderPerson(name: 'Bob', age: 20, gender: Gender.male),
      CoderPerson(name: 'King', age: 56, gender: Gender.male),
    ];
    var mainList = [
      CoderPerson(name: "Jane", age: 16, gender: Gender.female),
      CoderPerson(name: "Katy", age: 22, gender: Gender.female),
      CoderPerson(name: 'George', age: 17, gender: Gender.male),
      CoderPerson(name: 'Bruce', age: 47, gender: Gender.male)
    ];
    var res = mainList.intersectBy(intesectPersonList, (e) => e.age);
    expect(
        res.map((e) => e.toJson()), [CoderPerson(name: "Jane", age: 16, gender: Gender.female)].map((e) => e.toJson()));
  });
  test('shouldIntersectByLists', () {
    var intesectPersonList = [
      CoderPerson(name: "Jane", age: 16, gender: Gender.female),
      CoderPerson(name: 'Bob', age: 20, gender: Gender.male),
      CoderPerson(name: 'King', age: 56, gender: Gender.male),
    ];
    var mainList = [
      CoderPerson(name: "Jane", age: 16, gender: Gender.female),
      CoderPerson(name: "Katy", age: 22, gender: Gender.female),
      CoderPerson(name: 'George', age: 17, gender: Gender.male),
      CoderPerson(name: 'Bruce', age: 47, gender: Gender.male)
    ];
    var res = mainList.intersectBy(intesectPersonList, (e) => e.toJson().toJsonEncodedString);
    expect(
        res.map((e) => e.toJson()), [CoderPerson(name: "Jane", age: 16, gender: Gender.female)].map((e) => e.toJson()));
  });

  test('shouldUnionByLists', () {
    var intesectList = [1, 2, 3];
    var mainList = [2, 3, 4, 5];
    var res = mainList.unionBy(intesectList, (e) => e);
    expect(res, [1, 2, 3, 4, 5]);
  });

  test('shouldOrderByLists', () {
    // ignore: unused_local_variable
    var nullableList = [
      ...personList,
      CoderPerson(name: "Jannet", age: 16, gender: Gender.male),
    ].orderBy((element) => element.gender);
    // ignore: unused_local_variable
    var sortedList = personList.orderByMany(
      (element) => [
        MultiSorterArgs(field: element.age, orderDirection: OrderDirection.desc),
        MultiSorterArgs(field: element.name, orderDirection: OrderDirection.desc),
      ],
    );
    // ignore: unused_local_variable
    var sortedList2 = personList.orderBy((element) => element.name);
    var intList = List.of([1, null, 2]);
    var sortedIntList = intList.order().toList();
    var t = sortedIntList.first;
    expect(null, t);
  });
}
