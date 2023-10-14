import 'dart:convert';

import 'object_extensions.dart';

extension MapExtn<T, K> on Map<T, K>? {
  /// Removes null values from this [Map]
  Map<T, K> get removeNulls {
    if (isNull) return <T, K>{};
    return this!.where((key, value) => value.isNotNull);
  }

  /// Returns a new [Map] that has elements based on a [predicate]
  Map<T, K> where(bool Function(T key, K value) predicate) {
    if (isNull) return <T, K>{};
    var newMap = <T, K>{};
    newMap.addEntries(this!.entries.where((e) => predicate(e.key, e.value)));
    return newMap;
  }

  /// Returns whether this [Map] object is null or empty
  bool get isNullOrEmpty {
    if (isNull) return true;
    return this!.isEmpty;
  }

  /// Returns whether this [Map] object is not null nor empty
  bool get isNotNullOrEmpty {
    if (isNull) return false;
    return this!.isEmpty;
  }

  /// Returns the json encoded string of a nullable [Map] object
  String get toJsonEncodedString {
    if (isNullOrEmpty) return "{}";
    return jsonEncode(this!);
  }
}
