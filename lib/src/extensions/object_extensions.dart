import 'list_extensions.dart';

extension ObjectExn on Object? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool get isPrimitiveDataType {
    switch (runtimeType) {
      case String:
      case num:
      case DateTime:
      case bool:
        return true;
      default:
        return false;
    }
  }
}

extension FutureExn<T> on Future<T?> {
  /// Checks if value of future is null
  Future<bool> get isNull => then((value) => value == null);

  /// Checks if value of future is not null
  Future<bool> get isNotNull => then((value) => value != null);

  /// Returns future value as a [List]
  Future<List<T>> toListAsync() => then((value) => [value].removeNulls.toList());
}
