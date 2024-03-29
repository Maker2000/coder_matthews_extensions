import 'string_extensions.dart';

extension EnumExtn on Enum {
  /// Returns enum value as title case with space
  ///
  /// Example:
  /// ```dart
  /// enum Words { veryLongWord }
  /// print(Words.veryLongWord.titleCase); // prints "Very Long Word"
  /// ```
  /// See string extension function: [titleCase]
  String get titleCase => name.splitCamelCaseWord().titleCase;

  /// Useful when using go_router. Adds a '/' in front of the name of the enum
  String get toRoute => name.toRoute;

  /// Returns enum name in all uppercase
  String get toUpperCase => name.toUpperCase();

  /// Returns enum name in all lowerCase
  String get toLowerCase => name.toLowerCase();

  /// Returns enum name in snake_case
  String get toSnakeCase => name.camelCaseToSnakeCase;

  /// Returns enum name in PascalCase
  String get toPascalCase => name.camelCaseToPascalCase;
}

extension EnumListExt<T extends Enum> on Iterable<T> {
  /// Attempts to return the entered string as the typed enum should there be an exact match.
  /// This function is case sensitive
  T? byNameOrNull(String? name) {
    if (name == null) return null;
    for (var value in this) {
      if (value.name == name) return value;
    }
    return null;
  }

  /// Attempts to return the entered string as the typed enum should there be a match.
  /// This function is case insensitive
  T? byNameOrNullIgnoreCase(String? name) {
    if (name == null) return null;
    for (var value in this) {
      if (value.name.equalsIgnoreCase(name)) return value;
    }
    return null;
  }
}
