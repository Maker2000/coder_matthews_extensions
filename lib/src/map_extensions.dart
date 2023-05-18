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
}
