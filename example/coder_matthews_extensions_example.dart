import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';

void main() {
  //list examples
  final personList = [
    CoderPerson(name: "Jane", age: 16, gender: Gender.female),
    CoderPerson(name: 'Bob', age: 20, gender: Gender.male),
    CoderPerson(name: 'King', age: 56, gender: Gender.male),
    CoderPerson(name: "Joane", age: 18, gender: Gender.female),
    CoderPerson(name: "Katy", age: 22, gender: Gender.female),
    CoderPerson(name: 'George', age: 17, gender: Gender.male),
    CoderPerson(name: 'Bruce', age: 47, gender: Gender.male),
  ];

  final oldestPerson = personList.maxElement((element) => element.age);
  print(oldestPerson.age);

  final youngestPerson = personList.minElement((element) => element.age);
  print(youngestPerson.age);

  final group = personList.groupBy((e) => e.gender);
  print(group);
}
