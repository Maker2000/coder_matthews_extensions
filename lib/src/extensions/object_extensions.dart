import 'dart:async';

import 'list_extensions.dart';

extension ObjectExn<T extends Object?> on T? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool get isPrimitiveDataType {
    switch (runtimeType) {
      case const (String):
      case const (num):
      case const (DateTime):
      case const (bool):
        return true;
      default:
        return false;
    }
  }

  /// Converts this object to a future
  Future<T?> toCompletedFuture() => Future.value(this);

  /// Creates a list with this object as th eonly member. The list will be empty if this object is null
  List<T> toListEmptyWhenNull() => [this].removeNulls.toList();
}

extension ObjectExn2<T extends Object> on T {
  /// Converts this object to a future
  Future<T> toCompletedFuture() => Future.value(this);

  /// Creates a list with this object as th eonly member
  List<T> toListNotNull() => [this];
}

extension FutureExn<T> on Future<T?> {
  /// Checks if value of future is null
  Future<bool> get isNull => then((value) => value == null);

  /// Checks if value of future is not null
  Future<bool> get isNotNull => then((value) => value != null);

  /// Returns future value as a [List], returns and emoty list if the value is null
  Future<List<T>> toListAsync() => then((value) => [value].removeNulls.toList());
}
