class CoderPerson {
  String name;
  double age;
  Gender gender;
  DateTime get birthday => DateTime.now().subtract(Duration(days: 400 * age.toInt()));
  String get email => _generateRandomEmail;
  CoderPerson({required this.name, required this.age, required this.gender});

  String get _generateRandomEmail => '${name.replaceAll(' ', '').toLowerCase()}${name.length}@codermail.com';
  Map<String, dynamic> toJson() => {'name': name, 'age': age, 'gender': gender.name, 'email': email};
}

enum Gender { male, female }

enum TestingEnum { longTitle, aTitleToDoTheTest }
