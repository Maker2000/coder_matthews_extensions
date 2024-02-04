import 'dart:convert';

import 'object_extensions.dart';
import 'list_extensions.dart';

extension StringExtn on String? {
  static final _splitRegEx = RegExp(r"(?=(?!^)[A-Z])");

  ///Returns a bool whether string value is null or empty
  bool get isNullOrEmpty {
    if (isNull) return true;
    return this!.isEmpty;
  }

  /// Returns a bool value whether string value is not null or empty
  bool get isNotNullOrEmpty {
    if (isNull) return false;
    return this!.isNotEmpty;
  }

  /// Returns the sentence case of this string value.
  /// Example:
  /// ```dart
  /// String sentence = 'example Sentence.';
  /// debugPrint('${sentence.sentenceCase}') //prints 'Example sentence.'
  /// ```
  String get sentenceCase {
    if (isNull) return '';
    return this!.isNotEmpty ? '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}' : '';
  }

  /// Returns the title case of this string value.
  ///
  /// Example:
  /// ```dart
  /// String sentence = 'example Sentence.';
  /// debugPrint('${sentence.titleCase}') //prints 'Example Sentence.'
  /// ```
  String get titleCase {
    if (isNull) return "";
    return this!.replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.sentenceCase).join(" ");
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
    if (isNull) return '';
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
    if (isNull) return '';
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
    if (isNull) return false;
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this!);
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
    if (isNull) return "";
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
    if (isNull) return [];
    return this!.split(_splitRegEx);
  }

  /// Returns a json object that the encoded string is
  dynamic get toDecodedJson {
    if (isNullOrEmpty) return {};
    return jsonDecode(this!);
  }

  /// Checks if [this] string is contained within a [Iterable] of strings while ignoring the case
  bool inIgnoreCase(Iterable<String> data, [bool trim = true]) => data.containsIgnoreCase(this, trim);

  /// Checks if [this] string is equal to another string while ignoring the case
  bool equalsIgnoreCase(String other, [bool trim = true]) =>
      trim ? this?.toLowerCase().trim() == other.toLowerCase().trim() : this?.toLowerCase() == other.toLowerCase();

  /// Useful when using go_router. Adds a '/' in front of the name of the string.
  /// Will return an empty string if the string is null.
  String get toRoute => this == null ? "" : "/$this";

  /// Takes a nullable string and removes the [pattern] string from the string.
  String? remove(String pattern, [bool ignoreCase = true]) =>
      this?.replaceAll(RegExp(pattern, caseSensitive: !ignoreCase), '');

  /// Returns file extension should the string be a filename. Returns null of not a proper file name.
  String? get fileExtension {
    var extension = this?.split('.').lastOrNull;
    return extension == null ? null : ".$extension";
  }

  /// Returns file name should the string be a filename with extension. Returns null of not a proper file name.
  String? get actualFileName {
    var extension = this?.fileExtension;
    return this?.replaceAll(extension ?? '', '');
  }
}
