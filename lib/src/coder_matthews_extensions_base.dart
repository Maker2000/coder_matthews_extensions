import 'dart:math';

class CoderPerson {
  String name;
  double age;
  Gender gender;
  String get email => _generateRandomEmail;
  CoderPerson({required this.name, required this.age, required this.gender});

  String get _generateRandomEmail =>
      '${name.replaceAll(' ', '').toLowerCase()}${name.length}@codermail.com';
}

enum Gender { male, female }
