import 'dart:convert';

extension StringExtn on String? {
  static final _splitRegEx = RegExp(r"(?=(?!^)[A-Z])");

  ///Returns a bool whether string value is null or empty
  bool get isNullOrEmpty {
    if (this == null) return true;
    return this!.isEmpty;
  }

  /// Returns a bool value whether string value is not null or empty
  bool get isNotNullOrEmpty {
    if (this == null) return false;
    return this!.isNotEmpty;
  }

  /// Returns the sentence case of this string value.
  /// Example:
  /// ```dart
  /// String sentence = 'example Sentence.';
  /// debugPrint('${sentence.sentenceCase}') //prints 'Example sentence.'
  /// ```
  String get sentenceCase {
    if (this == null) return '';
    return this!.isNotEmpty
        ? '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}'
        : '';
  }

  /// Returns the title case of this string value.
  ///
  /// Example:
  /// ```dart
  /// String sentence = 'example Sentence.';
  /// debugPrint('${sentence.titleCase}') //prints 'Example Sentence.'
  /// ```
  String get titleCase {
    if (this == null) return "";
    return this!
        .replaceAll(RegExp(' +'), ' ')
        .split(" ")
        .map((str) => str.sentenceCase)
        .join(" ");
  }

  /// Strips string of all charactors except numbers
  ///
  /// Example:
  /// ``` dart
  /// String phoneNumber = (453) 945-8453;
  /// String onlyNumbers = phoneNumber.onlyNumbers;
  /// print(onlyNumbers); // "4539458453"
  /// ```
  String get onlyNumbers {
    if (this == null) return '';
    return this!.replaceAll(RegExp(r'[\D]'), "");
  }

  /// Formats a valid phone number.
  ///
  /// Formats to:
  /// - (000) 000-0000
  /// - 1 (000) 000-0000
  /// - 000-0000
  ///
  /// Returns digits of string this phone number is invalid
  String get toPhoneNumberString {
    if (this == null) return '';
    String data = this!.onlyNumbers;
    switch (data.length) {
      case 7:
        return "${data.substring(0, 3)}-${data.substring(3, 7)}";
      case 10:
        return "(${data.substring(0, 3)}) ${data.substring(3, 6)}-${data.substring(6, 10)}";
      case 11:
        return "(${data.substring(1, 4)}) ${data.substring(4, 8)}-${data.substring(8, 11)}";
      default:
        return data;
    }
  }

  /// Evaluates if this string is a valid email address.
  bool get isEmail {
    if (this == null) return false;
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this!);
  }

  /// Separates the camelcase word with a [separator] string
  ///
  /// Example:
  /// ```dart
  /// String sentence = "helloWorld!";
  /// String splitSentence = sentence.splitCamelCaseWord;
  /// print(splitSentence); // "hello World!"
  /// ```
  ///
  /// Example with [titleCase]
  /// ``` dart
  /// String sentence = "helloWorld!";
  /// String splitSentence = sentence.splitCamelCaseWord.titleCase;
  /// print(splitSentence); // "Hello World!"
  /// ```
  String splitCamelCaseWord([String separator = " "]) {
    if (this == null) return "";
    return this!.split(_splitRegEx).join(separator);
  }

  /// Separates the camelcase word into a string list
  ///
  /// Example:
  /// ```dart
  /// String sentence = "helloWorld!";
  /// String splitSentence = sentence.splitCamelCaseList;
  /// print(splitSentence); // ["hello", "World!"]
  /// ```
  List<String> get splitCamelCaseList {
    if (this == null) return [];
    return this!.split(_splitRegEx);
  }

  /// Returns a json object that the encoded string is
  Map<String, dynamic> get toDecodedJson {
    if (isNullOrEmpty) return {};
    return jsonDecode(this!);
  }
}
