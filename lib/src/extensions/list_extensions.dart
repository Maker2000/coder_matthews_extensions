import 'package:flutter/material.dart';
import '../helpers/enums.dart';
import 'object_extensions.dart';

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
  /// to use for the calculation. Using an empty list will return 0.
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
    if (this!.isEmpty) return 0;
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

  /// Searches a list using the first element matching given [predicate] and returns the element.
  /// If not found, it returns null
  T? firstWhereOrNull(bool Function(T element) predicate) {
    if (isNull) return null;
    try {
      return this!.firstWhere(predicate);
    } on StateError {
      return null;
    }
  }

  /// Searches a list using the last element matching given [predicate] and returns the element.
  /// If not found, it returns null
  T? lastWhereOrNull(bool Function(T element) predicate) {
    if (isNull) return null;
    try {
      return this!.lastWhere(predicate);
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

  /// An expand function that applies an [expand] operation to futures.
  /// Specify a [maxParallelisms] ie: the amount of futures to be run at once till the list is completed. Defaults to 1
  Future<Iterable<K>> expandAsync<K>(Future<Iterable<K>> Function(T element) op, [int maxParallelisms = 1]) async {
    if (this == null) return [];
    var res = await this!.mapAsync(op, maxParallelisms);
    return res.expand((element) => element);
  }

  /// A map function that applies a [map] operation to futures.
  /// Specify a [maxParallelisms] ie: the amount of futures to be run at once till the list is completed. Defaults to 1
  Future<Iterable<K>> mapAsync<K>(Future<K> Function(T element) op, [int maxParallelisms = 1]) async {
    if (this == null) return Future.value([]);
    var res = <K>[];
    var counter = 0;
    do {
      var ops = this!.skip(counter * maxParallelisms).take(maxParallelisms);
      res.addAll(await Future.wait(ops.map(op)));
      counter++;
    } while (res.length < this!.length);
    return res;
  }

  /// A modified map function that contains the current index of the iterated.
  Iterable<K> mapWithIndex<K>(K Function(T element, int index) op) {
    if (this == null) return [];
    return this!.indexed.map((e) => op(e.$2, e.$1));
  }

  /// Returns a [T] element with the maximum [DateTime] of a collection of [T] elements.
  ///
  /// [op] requires a [DateTime] to be returned. Returns [Null] if list is empty
  ///
  /// Object Example:
  /// ``` dart
  /// final dateList = <Map<String, DateTime>>[
  ///   {"date": DateTime.now()},
  ///   {"date": DateTime.now().add(Duration(days: 5))},
  ///   {"date": DateTime.now().subtract(Duration(days: 5))},
  /// ];
  /// final max = dateList.maxDate((element) => element["date"]!);
  /// print(max); // {"date": 5 days after the current date}
  /// ```
  /// List of [DateTime]   Example:
  /// ``` dart
  /// final dateList = <DateTime>[
  ///   DateTime.now(),
  ///   DateTime.now().add(Duration(days: 5),
  ///   DateTime.now().subtract(Duration(days: 5)
  /// ];
  /// final max = dateList.maxDate((element) => element);
  /// print(max); // Prints 5 days after the current date
  /// ```
  T? maxDate(DateTime Function(T element) op) {
    if (this == null) return null;
    if (this!.isEmpty) return null;
    return this!.fold(
      this!.firstOrNull,
      (previousValue, element) => previousValue == null
          ? element
          : op(previousValue).isAfter(op(element))
              ? previousValue
              : element,
    );
  }

  /// Returns a [T] element with the minimum [DateTime] of a collection of [T] elements.
  ///
  /// [op] requires a [DateTime] to be returned. Returns [Null] if list is empty
  ///
  /// Object Example:
  /// ``` dart
  /// final dateList = <Map<String, DateTime>>[
  ///   {"date": DateTime.now()},
  ///   {"date": DateTime.now().add(Duration(days: 5))},
  ///   {"date": DateTime.now().subtract(Duration(days: 5))},
  /// ];
  /// final min = dateList.minDate((element) => element["date"]!);
  /// print(min); // {"date": 5 days before the current date}
  /// ```
  /// List of [DateTime]   Example:
  /// ``` dart
  /// final dateList = <DateTime>[
  ///   DateTime.now(),
  ///   DateTime.now().add(Duration(days: 5),
  ///   DateTime.now().subtract(Duration(days: 5),
  /// ];
  /// final min = dateList.minDate((element) => element);
  /// print(min); // Prints 5 days before the current date
  /// ```
  T? minDate(DateTime Function(T element) op) {
    if (this == null) return null;
    if (this!.isEmpty) return null;
    return this!.fold(
      this!.firstOrNull,
      (previousValue, element) => previousValue == null
          ? element
          : op(previousValue).isBefore(op(element))
              ? previousValue
              : element,
    );
  }

  /// Returns the maximum [Element] of a collection of [T] elements.
  ///
  /// [number] requires a [num] to be returned. Returns a [Null] if list is empty
  ///
  /// Object Example:
  /// ``` dart
  /// final valueList = <Map<String, double>>[{"value": 1.3},{"value": 1},{"value": 2.7},];
  /// final max = valueList.maxElement((element) => element["value"]!);
  /// print(max); // {"value": 2.7}
  /// ```
  /// List of [double]   Example:
  /// ``` dart
  /// final valueList = <double>[1.3, 1, 2.7];
  /// final max = valueList.maxElement((element) => element);
  /// print(max); // 2.7
  /// ```
  T? maxElement(num Function(T element) number) {
    if (this == null) return null;
    if (this!.isEmpty) return null;
    return this!.fold(
        this!.firstOrNull,
        (previousValue, element) => previousValue == null
            ? element
            : number(previousValue) > number(element)
                ? previousValue
                : element);
  }

  /// Returns the minumum [Element] of a collection of [T] elements.
  ///
  /// [number] requires a [num] to be returned. Returns [Null] if list is empty
  ///
  /// Object Example:
  /// ``` dart
  /// final valueList = <Map<String, double>>[{"value": 1.3},{"value": 1},{"value": 2.7},];
  /// final min = valueList.minElement((element) => element["value"]!);
  /// print(min); // {"value": 1}
  /// ```
  /// List of [double]   Example:
  /// ``` dart
  /// final valueList = <double>[1.3, 1, 2.7];
  /// final min = valueList.minElement((element) => element);
  /// print(min); // 1
  /// ```
  T? minElement(num Function(T element) number) {
    if (this == null) return null;
    if (this!.isEmpty) return null;
    return this!.fold(
        this!.firstOrNull,
        (previousValue, element) => previousValue == null
            ? element
            : number(previousValue) < number(element)
                ? previousValue
                : element);
  }

  // Iterable<T> intersect(Iterable<T> other, Map<String, dynamic> Function(T element) converter) {
  //   if (this == null) return List.empty();
  //   var es = this!
  //       .map((e) => converter(e).toJsonEncodedString)
  //       .toSet()
  //       .intersection(other.map((e) => converter(e).toJsonEncodedString).toSet())
  //       .toList();
  //   var res = <T>[];
  //   var remap = T.isPrimitiveDataType ? other : other.map((e) => jsonEncode(e));
  //   for (var e in this!) {
  //     if (remap.contains(T.isPrimitiveDataType ? jsonEncode(e) : e)) res.add(e);
  //   }
  //   return res;
  // }

  /// Returns a iterable containing the elements that exists within both this [Iterable] and the [other]
  /// [Iterable] using the returning property coming from the predicate
  Iterable<T> intersectBy<K>(Iterable<T> other, K Function(T item) predicate) {
    if (this == null) return List.empty();
    var res = <T>[];
    var otherConverted = other.map(predicate).toList();
    for (var e in this!) {
      if (otherConverted.contains(predicate(e))) res.add(e);
    }
    return res;
  }

  /// Returns a new list that is ordered by the property returned from the operation [op].
  ///
  /// Will throw and [UnsupportedError] exception if the data type returned by the [op] is not supported in the sort
  Iterable<T> orderBy<K>(K? Function(T element) op, [OrderDirection dir = OrderDirection.asc]) {
    if (this == null) return [];
    var shadowThis = this!;
    int Function(T a, T b) sorter = switch (K) {
      (num) => (a, b) =>
          _orderByHelper(op(a), op(b)).$2 ? _orderByHelper(op(a), op(b)).$1! : (op(a) as num).compareTo(op(b) as num),
      (DateTime) => (a, b) => _orderByHelper(op(a), op(b)).$2
          ? _orderByHelper(op(a), op(b)).$1!
          : (op(a) as DateTime).compareTo(op(b) as DateTime),
      (Duration) => (a, b) => _orderByHelper(op(a), op(b)).$2
          ? _orderByHelper(op(a), op(b)).$1!
          : (op(a) as Duration).compareTo(op(b) as Duration),
      (TimeOfDay) => (a, b) {
          if (_orderByHelper(op(a), op(b)).$2) {
            return _orderByHelper(op(a), op(b)).$1!;
          } else {
            var aTime = (op(a) as TimeOfDay).hour + (op(a) as TimeOfDay).minute / 60;
            var bTime = (op(b) as TimeOfDay).hour + (op(b) as TimeOfDay).minute / 60;
            return aTime.compareTo(bTime);
          }
        },
      (Enum) => (a, b) => _orderByHelper(op(a), op(b)).$2
          ? _orderByHelper(op(a), op(b)).$1!
          : (op(a) as Enum).name.compareTo((op(b) as Enum).name),
      (String) => (a, b) => _orderByHelper(op(a), op(b)).$2
          ? _orderByHelper(op(a), op(b)).$1!
          : op(a).toString().compareTo(op(b).toString()),
      _ => throw UnsupportedError('$K data type is not supported by this order by')
    };
    return List.from(shadowThis)..sort((a, b) => sorter(a, b) * (dir == OrderDirection.asc ? 1 : -1));
  }

  (int?, bool) _orderByHelper<O>(O a, O b) {
    if (a == null && b == null) return (0, true);
    if (a == null) return (1, true);
    if (b == null) return (-1, true);
    return (null, false);
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
  /// Checks if this Iterable of string contains a string [element] while ignoring the case
  bool containsIgnoreCase(String? element) {
    for (var e in this) {
      if (e.toLowerCase() == element?.toLowerCase()) return true;
    }
    return false;
  }
}

extension FutureListExtn<TSouce> on Future<Iterable<TSouce>> {
  /// converts a [Future]<[Iterable]> to a [Future]<[List]>
  Future<List<TSouce>> toListAsync() {
    return then((value) => value.toList());
  }
}
