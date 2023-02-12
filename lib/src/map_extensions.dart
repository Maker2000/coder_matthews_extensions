extension MapExtn<T, K> on Map<T, K>? {
  /// Removes null values from this [Map]
  Map<T, K> get removeNulls {
    if (this == null) return <T, K>{};
    var newMap = <T, K>{};
    newMap.addAll(this!);
    newMap.removeWhere((key, value) => value == null);
    return newMap;
  }
}
