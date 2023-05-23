import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';

extension EnumExtn on Enum {
  /// Returns enum value as title case with space
  ///
  /// Example: veryLongWord => Very Long Word.
  ///
  /// See string extension function: [titleCase]
  String get titleCase => name.splitCamelCaseWord().titleCase;
}
