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
  Future<bool> get isNull async => (await this) == null;
  Future<bool> get isNotNull async => (await this) != null;
}
