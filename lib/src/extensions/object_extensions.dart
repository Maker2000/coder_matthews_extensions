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

  Future<T?> toCompletedFuture() => Future.value(this);
}

extension ObjectExn2<T extends Object> on T {
  Future<T> toCompletedFuture() => Future.value(this);
}

extension FutureExn<T> on Future<T?> {
  /// Checks if value of future is null
  Future<bool> get isNull => then((value) => value == null);

  /// Checks if value of future is not null
  Future<bool> get isNotNull => then((value) => value != null);

  /// Returns future value as a [List]
  Future<List<T>> toListAsync() => then((value) => [value].removeNulls.toList());
}
