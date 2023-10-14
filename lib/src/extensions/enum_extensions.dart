import 'string_extensions.dart';

extension EnumExtn on Enum {
  /// Returns enum value as title case with space
  ///
  /// Example: veryLongWord => Very Long Word.
  ///
  /// See string extension function: [titleCase]
  String get titleCase => name.splitCamelCaseWord().titleCase;

  /// Useful when using go_router. Adds a '/' in front of the name of the enum
  String get toRoute => name.toRoute;

  /// Returns enum name in all uppercase
  String get toUpperCase => name.toUpperCase();

  /// Returns enum name in all lowerCase
  String get toLowerCase => name.toLowerCase();
}

extension EnumListExt<T extends Enum> on Iterable<T> {
  /// Used on a li
  T? byNameOrNull(String? name) {
    if (name == null) return null;
    for (var value in this) {
      if (value.name == name) return value;
    }
    return null;
  }
}
