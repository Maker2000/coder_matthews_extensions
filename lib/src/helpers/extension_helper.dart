import 'package:flutter/material.dart';

import 'classes.dart';
import 'enums.dart';

class ExtensionHelper {
  static int sorter<T>(T? a, T? b, Error toThrow) {
    if (a is Comparable) return _orderByHelper(a, b).$2 ? _orderByHelper(a, b).$1 : a.compareTo(b);
    switch (a) {
      case const (TimeOfDay):
        if (_orderByHelper(a, b).$2) {
          return _orderByHelper(a, b).$1;
        } else {
          var aTime = (a as TimeOfDay).hour + (a).minute / 60;
          var bTime = (b as TimeOfDay).hour + (b).minute / 60;
          return aTime.compareTo(bTime);
        }
      default:
        try {
          return _orderByHelper(a, b).$2 ? _orderByHelper(a, b).$1 : (a as Enum).name.compareTo((b as Enum).name);
        } catch (e) {
          throw toThrow;
        }
    }
  }

  static int multipleSorter<T>((MultiSorterArgs a, MultiSorterArgs b) Function(int index) args,
      Error Function(Type dateType) toThrow, int sortLength,
      [int currentIndex = 0]) {
    var currentArgs = args(currentIndex);
    var res = sorter(currentArgs.$1.field, currentArgs.$2.field, toThrow(T)) *
        (args(currentIndex).$1.orderDirection == OrderDirection.asc ? 1 : -1);
    return res == 0 && currentIndex < sortLength ? multipleSorter(args, toThrow, sortLength, currentIndex + 1) : res;
  }

  static (int, bool) _orderByHelper<O>(O? a, O? b) {
    if (a == null && b == null) return (0, true);
    if (a == null) return (-1, true);
    if (b == null) return (1, true);
    return (0, false);
  }
}
