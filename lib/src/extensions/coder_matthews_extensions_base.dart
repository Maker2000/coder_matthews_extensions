import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';

class CoderPerson {
  String name;
  int age;
  Gender gender;
  DateTime get birthday => DateTime.now().subtract(Duration(days: 400 * age.toInt()));
  String get email => _generateRandomEmail;
  CoderPerson({required this.name, required this.age, required this.gender});

  String get _generateRandomEmail => '${name.replaceAll(' ', '').toLowerCase()}${name.length}@codermail.com';
  Map<String, dynamic> toJson() => {'name': name, 'age': age, 'gender': gender.name, 'email': email};
  factory CoderPerson.decode(Map<String, dynamic> json) => CoderPerson(
      name: json['name'], age: json['age'], gender: Gender.values.byNameOrNull(json['gender']) ?? Gender.male);
}

enum Gender { male, female }

enum TestingEnum { longTitle, aTitleToDoTheTest }
