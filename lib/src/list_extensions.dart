extension ListExtn<T> on Iterable<T>? {
  /// Checks if given list contains an element of the given type [T]
  bool containsElement(T Function() f) {
    if (this == null) return false;
    for (T e in this!) {
      if (e == f.call()) return true;
    }
    return false;
  }

  /// Checks if one or more elements in list passes the pridicate [f]
  ///
  /// Example:
  /// ```dart
  /// List<String> names = ['Jane', 'Josh', 'George'];
  /// bool result = names.compoundOr((x) => x.startsWith('J'));
  /// debugPrint('$result'); //prints true
  /// ```
  bool compoundOr(bool Function(T e) f) {
    if (this == null) return false;
    return this!
        .fold(false, (previousValue, element) => previousValue || f(element));
  }

  /// Checks if all elements in list passes the pridicate [f]
  ///
  /// Example
  /// ```dart
  /// List<String> names = ['Jane', 'Josh', 'George'];
  /// bool result = names.compoundAnd((x) => x.startsWith('J'));
  /// debugPrint('$result'); //prints false
  /// ```
  bool compoundAnd(bool Function(T e) f) {
    if (this == null) return false;
    return this!
        .fold(false, (previousValue, element) => previousValue && f(element));
  }

  /// Returns a new [Iterable] with no null values.
  ///
  ///  If [Iterable] is null, an empty [Iterable] is returned.
  Iterable<T> get removeNulls {
    if (this == null) return <T>[];
    return this!.where((element) => element != null);
  }

  /// Calculates the sum of a collection of [T] elements.
  ///
  /// [sumFunction] requires a [num] to be returned
  /// to use for the calculation.
  ///
  /// Object Example:
  /// ``` dart
  /// final valueList = <Map<String, double>>[{"value": 1.3},{"value": 1},{"value": 2.7},];
  /// final total = valueList.sum((element) => element["value"]!);
  /// print(total); // 5
  /// ```
  /// List of [double] Example:
  /// ``` dart
  /// final valueList = <double>[1.3, 1, 2.7];
  /// final total = valueList.sum((element) => element);
  /// print(total); // 5
  /// ```
  num sum(num Function(T) sumFunction) {
    if (this == null) return 0;
    return this!.fold(
      0,
      (previousValue, element) => previousValue + sumFunction(element),
    );
  }

  /// Calculates the average of a collection of [T] elements.
  ///
  /// [sumFunction] requires a [num] to be returned
  /// to use for the calculation. Using an empty list will throw an [UnsupportedError].
  ///
  /// Object Example:
  /// ``` dart
  /// final valueList = <Map<String, double>>[{"value": 1.3},{"value": 1},{"value": 2.7},];
  /// final average = valueList.average((element) => element["value"]!);
  /// print(average); // 1.6666666666666667
  /// ```
  /// List of [double]   Example:
  /// ``` dart
  /// final valueList = <double>[1.3, 1, 2.7];
  /// final average = valueList.average((element) => element);
  /// print(average); // 1.6666666666666667
  /// ```
  num average(num Function(T) sumFunction) {
    if (this == null) return 0;
    if (this!.isEmpty) {
      throw UnsupportedError(
          'List needs to have elements to perform average calculation');
    }
    return sum(sumFunction) / this!.length;
  }

  /// Groups a collection and returns a list of [Map<K, List<T>>] elements.
  /// The Collection gets grouped by [K]
  ///
  /// Example grouping list by age:
  /// ``` dart
  /// final list = [
  ///   {"age": 10, "name": "Tom"},
  ///   {"age": 11, "name": "Jane"},
  ///   {"age": 12, "name": "Kim"},
  ///   {"age": 12, "name": "John"},
  ///   {"age": 10, "name": "Peart"},
  /// ];
  /// var result = list.groupBy((e) => e["age"]);
  /// print(result);
  /// /*
  /// Prints:
  /// {
  ///   10: [
  ///     {"age": 10, "name": "Tom"},
  ///     {"age": 10, "name": "Peart"}
  ///   ],
  ///   11: [
  ///     {"age": 11, "name": "Jane"}
  ///   ],
  ///   12: [
  ///     {"age": 12, "name": "Kim"},
  ///     {"age": 12, "name": "John"}
  ///   ]
  /// };
  /// */
  /// ```
  Map<K, List<T>> groupBy<K>(K Function(T e) keyFunction) {
    if (this == null) return <K, List<T>>{};
    return this!.fold(
        <K, List<T>>{},
        (Map<K, List<T>> map, T element) =>
            map..putIfAbsent(keyFunction(element), () => <T>[]).add(element));
  }
}
