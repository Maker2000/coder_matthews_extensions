<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A variety of extensions I use in my projects.

## Features

    Package contains extensions for lists and strings.

## Getting started

No setup required, just import the package.

## Usage

### List Extensions

```dart
  final personList = [
    CoderPerson(name: "Jane", age: 16, gender: Gender.female),
    CoderPerson(name: 'Bob', age: 20, gender: Gender.male),
    CoderPerson(name: 'King', age: 56, gender: Gender.male),
  ];

  final oldestPerson = personList.maxElement((element) => element.age);
  final youngestPerson = personList.minElement((element) => element.age);
  final totalAges = personList.sum((element) => element.age);
```

### String Extensions

```dart
  var control = '(342) 342-2314';
  var result = number.toPhoneNumberString;

  String email = 'testemail@mail.com';
  email.isEmail;

```

Check example folder for more.

## Additional information
