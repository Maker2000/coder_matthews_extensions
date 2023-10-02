import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';
import 'package:flutter/material.dart';

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
  debugPrint(oldestPerson?.age.toString());

  final youngestPerson = personList.minElement((element) => element.age);
  debugPrint(youngestPerson?.age.toString());

  final group = personList.groupBy((e) => e.gender);
  debugPrint(group.toString());

  //string examples

  const testerString = 'the Sky IS BluE.';
  var number = '+1 (342) 342-2314';
  debugPrint(number.onlyNumbers);

  number = '13423422314';
  debugPrint(number.toPhoneNumberString);

  debugPrint('Email: ${personList.first.email}, IsEmail: ${personList.first.email.isEmail}');
  debugPrint(testerString.sentenceCase);
  debugPrint(testerString.titleCase);
}
