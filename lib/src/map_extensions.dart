import 'dart:convert';

extension MapExtn<T, K> on Map<T, K>? {
  /// Removes null values from this [Map]
  Map<T, K> get removeNulls {
    if (this == null) return <T, K>{};
    return this!.where((key, value) => value != null);
  }

  /// Returns a new [Map] that has elements based on a [predicate]
  Map<T, K> where(bool Function(T key, K value) predicate) {
    if (this == null) return <T, K>{};
    var newMap = <T, K>{};
    newMap.addEntries(this!.entries.where((e) => predicate(e.key, e.value)));
    return newMap;
  }

  /// Returns whether this [Map] object is null or empty
  bool get isNullOrEmpty {
    if (this == null) return true;
    return this!.isEmpty;
  }

  /// Returns whether this [Map] object is not null nor empty
  bool get isNotNullOrEmpty {
    if (this == null) return false;
    return this!.isEmpty;
  }

  /// Returns the json encoded string of a nullable [Map] object
  String get toJsonEncodedString {
    if (isNullOrEmpty) return "{}";
    return jsonEncode(this!);
  }
}
