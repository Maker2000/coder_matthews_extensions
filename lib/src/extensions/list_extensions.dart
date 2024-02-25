import '../helpers/classes.dart';
import '../helpers/enums.dart';
import '../helpers/extension_helper.dart';
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
  /// [op] requires a [T] element to be returned.
  ///
  /// Supports: [num], [double], [int], [DateTime], [TimeOfDay], [Duration], [String], [Enum], [Comparable]
  ///
  /// Object Example:
  /// ``` dart
  /// final valueList = <Map<String, double>>[{"value": 1.3},{"value": 1},{"value": 2.7},];
  /// final max = valueList.maxValue((element) => element["value"]!);
  /// print(max); // 2.7
  /// ```
  /// List of [double]   Example:
  /// ``` dart
  /// final valueList = <double>[1.3, 1, 2.7];
  /// final max = valueList.max((element) => element);
  /// print(max); // 2.7
  /// ```
  T? max<K>(K Function(T value) op) {
    if (isNullOrEmpty) return null;
    return this!.orderBy(op, OrderDirection.desc).first;
  }

  /// Returns the minumum value of a collection of [T] elements.
  ///
  /// [op] requires a [T] element to be returned.
  ///
  /// Supports: [num], [double], [int], [DateTime], [TimeOfDay], [Duration], [String], [Enum], [Comparable]
  ///
  /// Object Example:
  /// ``` dart
  /// final valueList = <Map<String, double>>[{"value": 1.3},{"value": 1},{"value": 2.7},];
  /// final min = valueList.minValue((element) => element["value"]!);
  /// print(min); // 1
  /// ```
  /// List of [double]   Example:
  /// ``` dart
  /// final valueList = <double>[1.3, 1, 2.7];
  /// final min = valueList.minValue((element) => element);
  /// print(min); // 1
  /// ```
  T? min<K>(K Function(T value) op) {
    if (isNullOrEmpty) return null;
    return this!.orderBy(op).first;
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

  /// Returns a iterable that combines the elements within both this [Iterable] and the [other]
  /// [Iterable] without duplicates using the returning property coming from the predicate
  Iterable<T> unionBy<K>(Iterable<T> other, K Function(T item) predicate) {
    if (this == null) return List.empty();
    var res = List.of(this!);
    var otherConverted = other.map(predicate);
    for (var e in this!) {
      if (!otherConverted.contains(predicate(e))) res.add(e);
    }
    return res;
  }

  /// Returns a new list that is ordered by the property returned from the operation [op].
  ///
  /// Supports: [num], [double], [int], [DateTime], [TimeOfDay], [Duration], [String], [Enum], [Comparable]
  ///
  /// Will throw and [UnsupportedError] exception if the data type returned by the [op] is not supported in the sort
  Iterable<T> orderBy<K>(K? Function(T element) op, [OrderDirection dir = OrderDirection.asc]) {
    if (this == null) return [];
    var shadowThis = this!;
    return List<T>.from(shadowThis)
      ..sort((a, b) =>
          ExtensionHelper.sorter<K>(op(a), op(b), UnsupportedError('$K data type is not supported by this order by')) *
          (dir == OrderDirection.asc ? 1 : -1));
  }

  /// Returns a new list that is ordered by the list of properties returned from the operation [ops].
  /// NOTE: the list will be sorted by the order of the operations entered.
  ///
  /// Supports: [num], [double], [int], [DateTime], [TimeOfDay], [Duration], [String], [Enum]
  ///
  /// Will throw and [UnsupportedError] exception if the data type returned by the [op] is not supported in the sort
  /// Example:
  /// ```dart
  /// var personList = [
  ///   CoderPerson(name: "Jane", age: 16, gender: Gender.female),
  ///   CoderPerson(name: "Bobbet", age: 16, gender: Gender.female),
  ///   CoderPerson(name: "Xanders", age: 16, gender: Gender.male),
  ///   CoderPerson(name: 'Bob', age: 20, gender: Gender.male),
  ///   CoderPerson(name: 'King', age: 56, gender: Gender.male),
  /// ];
  /// var sortedList = personList.orderByMany(
  ///     (element) => [
  ///      MultiSorterArgs(field: element.age, orderDirection: OrderDirection.desc),
  ///      MultiSorterArgs(field: element.name, orderDirection: OrderDirection.desc),
  ///    ],
  ///  );
  /// ```
  Iterable<T> orderByMany<K>(List<MultiSorterArgs> Function(T element) ops) {
    if (this == null) return [];
    var shadowThis = this!;
    return List<T>.from(shadowThis)
      ..sort((a, b) {
        return ExtensionHelper.multipleSorter((index) => (ops(a)[index], ops(b)[index]),
            (dataType) => UnsupportedError('$dataType data type is not supported by this order by'), ops(a).length - 1);
      });
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

  /// Returns a new list that is ordered by the property returned from the operation [op].
  ///
  /// Will throw and [UnsupportedError] exception if the data type returned by the [op] is not supported in the sort
  Iterable<T?> order([OrderDirection dir = OrderDirection.asc]) {
    if (this == null) return [];
    var shadowThis = this!;
    var res = shadowThis.toList()
      ..sort((a, b) =>
          ExtensionHelper.sorter<T>(
              a,
              b,
              UnsupportedError(
                  '$T data type is not supported by this order function. Try using orderBy for more complex objects')) *
          (dir == OrderDirection.asc ? 1 : -1));
    return res;
  }
}

extension StringListExn on Iterable<String> {
  /// Checks if this Iterable of string contains a string [element] while ignoring the case
  bool containsIgnoreCase(String? element, [bool trim = true]) {
    for (var e in this) {
      if (trim ? e.toLowerCase().trim() == element?.toLowerCase().trim() : e.toLowerCase() == element?.toLowerCase()) {
        return true;
      }
    }
    return false;
  }
}

extension FutureListExtn<TSouce> on Future<Iterable<TSouce>> {
  /// converts a [Future]<[Iterable]> to a [Future]<[List]>
  Future<List<TSouce>> toListAsync() => then((value) => value.toList());
}

extension FutureListListExtn<TSouce> on Future<Iterable<Iterable<TSouce>>> {
  /// converts a [Future]<[Iterable]<[Iterable]>> to a [Future]<[List]>
  Future<List<TSouce>> toListFlattenAsync() => then((value) => value.expand((element) => element).toList());
}
