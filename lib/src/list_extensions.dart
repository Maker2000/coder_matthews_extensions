import 'package:coder_matthews_extensions/coder_matthews_extensions.dart';

extension NullableListExtn<T> on Iterable<T>? {
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
  num sum(num Function(T element) sumFunction) {
    if (isNull) return 0;
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
    if (isNull) return 0;
    if (this!.isEmpty) {
      throw UnsupportedError('List needs to have elements to perform average calculation');
    }
    return sum(sumFunction) / this!.length;
  }

  /// Returns the maximum value of a collection of [T] elements.
  ///
  /// [number] requires a [num] to be returned
  ///
  /// Object Example:
  /// ``` dart
  /// final valueList = <Map<String, double>>[{"value": 1.3},{"value": 1},{"value": 2.7},];
  /// final max = valueList.maxValue((element) => element["value"]!);
  /// print(average); // 2.7
  /// ```
  /// List of [double]   Example:
  /// ``` dart
  /// final valueList = <double>[1.3, 1, 2.7];
  /// final max = valueList.max((element) => element);
  /// print(average); // 2.7
  /// ```
  num maxValue(num Function(T value) number) {
    if (isNull) return 0;
    if (this!.isEmpty) return 0;
    return this!.fold(number(this!.first),
        (previousValue, element) => previousValue > number(element) ? previousValue : number(element));
  }

  /// Returns the minumum value of a collection of [T] elements.
  ///
  /// [number] requires a [num] to be returned
  ///
  /// Object Example:
  /// ``` dart
  /// final valueList = <Map<String, double>>[{"value": 1.3},{"value": 1},{"value": 2.7},];
  /// final max = valueList.minValue((element) => element["value"]!);
  /// print(average); // 1
  /// ```
  /// List of [double]   Example:
  /// ``` dart
  /// final valueList = <double>[1.3, 1, 2.7];
  /// final max = valueList.minValue((element) => element);
  /// print(average); // 1
  /// ```
  num minValue(num Function(T value) number) {
    if (isNull) return 0;
    if (this!.isEmpty) return 0;
    return this!.fold(number(this!.first),
        (previousValue, element) => previousValue < number(element) ? previousValue : number(element));
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
    if (isNull) return <K, List<T>>{};
    return this!.fold(<K, List<T>>{},
        (Map<K, List<T>> map, T element) => map..putIfAbsent(keyFunction(element), () => <T>[]).add(element));
  }

  /// Searches a list using the given [predicate] and returns the element.
  /// If not found, it returns null
  T? firstWhereOrNull(bool Function(T element) predicate) {
    if (isNull) return null;
    try {
      return this!.firstWhere(predicate);
    } on StateError {
      return null;
    }
  }

  ///Returns an [Iterable] of [T] elements with the [element] is added between each member of the list
  /// EXample:
  /// ```dart
  /// var numbers = [1,2,3];
  /// print(numbers.addBetween(0)); // prints 1, 0, 2, 0, 3
  /// ```
  Iterable<T> addBetween(T element) sync* {
    if (isNull) yield* [];
    var ghost = this!;
    for (var i = 0; i < ghost.length; i++) {
      if (i == 0) {
        yield* [ghost.first];
      } else {
        yield* [element, ghost.elementAt(i)];
      }
    }
  }

  /// Returns a [bool] whether or not this [List] is null or empty
  bool get isNullOrEmpty {
    if (isNull) return true;
    return this!.isEmpty;
  }

  /// Returns a [bool] whether or not this [List] is not null or empty
  bool get isNotNullOrEmpty {
    if (isNull) return false;
    return this!.isEmpty;
  }

  Future<Iterable<K>> expandAsync<K>(Future<Iterable<K>> Function(T element) op) async {
    if (this == null) return [];
    var res = await this!.mapAsync(op);
    return res.expand((element) => element);
  }

  Future<Iterable<K>> mapAsync<K>(Future<K> Function(T element) op) async {
    if (this == null) return [];
    return await Future.wait(this!.map(op));
  }
}

extension ListExtn<T> on Iterable<T> {
  /// Returns the maximum [Element] of a collection of [T] elements.
  ///
  /// [number] requires a [num] to be returned. Throws [UnsupportedError] if list is empty
  ///
  /// Object Example:
  /// ``` dart
  /// final valueList = <Map<String, double>>[{"value": 1.3},{"value": 1},{"value": 2.7},];
  /// final max = valueList.maxElement((element) => element["value"]!);
  /// print(average); // {"value": 2.7}
  /// ```
  /// List of [double]   Example:
  /// ``` dart
  /// final valueList = <double>[1.3, 1, 2.7];
  /// final max = valueList.max((element) => element);
  /// print(average); // 2.7
  /// ```
  T maxElement(num Function(T element) number) {
    if (isEmpty) {
      throw UnsupportedError('Cannot use this function on empty list');
    }
    return fold(first, (previousValue, element) => number(previousValue) > number(element) ? previousValue : element);
  }

  /// Returns the minumum [Element] of a collection of [T] elements.
  ///
  /// [number] requires a [num] to be returned. Throws [UnsupportedError] if list is empty
  ///
  /// Object Example:
  /// ``` dart
  /// final valueList = <Map<String, double>>[{"value": 1.3},{"value": 1},{"value": 2.7},];
  /// final max = valueList.maxElement((element) => element["value"]!);
  /// print(average); // {"value": 1}
  /// ```
  /// List of [double]   Example:
  /// ``` dart
  /// final valueList = <double>[1.3, 1, 2.7];
  /// final max = valueList.max((element) => element);
  /// print(average); // 1
  /// ```
  T minElement(num Function(T element) number) {
    if (isEmpty) {
      throw UnsupportedError('Cannot use this function on empty list');
    }
    return fold(first, (previousValue, element) => number(previousValue) < number(element) ? previousValue : element);
  }
}

extension NullableListExtn2<T> on Iterable<T?>? {
  /// Returns a new [Iterable] with no null values.
  ///
  ///  If [Iterable] is null, an empty [Iterable] is returned.
  Iterable<T> get removeNulls {
    var returnList = <T>[];
    if (isNull) return returnList;
    for (var element in this!) {
      if (element != null) returnList.add(element);
    }
    return returnList;
  }
}

extension StringListExn on Iterable<String> {
  bool isInIgnoreCase(String val) {
    for (var e in this) {
      if (e.toLowerCase() == val.toLowerCase()) return true;
    }
    return false;
  }
}
