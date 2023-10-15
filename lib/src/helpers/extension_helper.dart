import 'package:flutter/material.dart';

class ExtensionHelper {
  static int Function(T?, T?) sorter<T>(Error toThrow) => switch (T) {
        (num || double || int) => (a, b) =>
            _orderByHelper(a, b).$2 ? _orderByHelper(a, b).$1 : (a as num).compareTo(b as num),
        (DateTime) => (a, b) =>
            _orderByHelper(a, b).$2 ? _orderByHelper(a, b).$1 : (a as DateTime).compareTo(b as DateTime),
        (Duration) => (a, b) =>
            _orderByHelper(a, b).$2 ? _orderByHelper(a, b).$1 : (a as Duration).compareTo(b as Duration),
        (TimeOfDay) => (a, b) {
            if (_orderByHelper(a, b).$2) {
              return _orderByHelper(a, b).$1;
            } else {
              var aTime = (a as TimeOfDay).hour + (a).minute / 60;
              var bTime = (b as TimeOfDay).hour + (b).minute / 60;
              return aTime.compareTo(bTime);
            }
          },
        (String) => (a, b) => _orderByHelper(a, b).$2 ? _orderByHelper(a, b).$1 : a.toString().compareTo(b.toString()),
        _ => (a, b) {
            try {
              return _orderByHelper(a, b).$2 ? _orderByHelper(a, b).$1 : (a as Enum).name.compareTo((b as Enum).name);
            } catch (e) {
              throw toThrow;
            }
          },
      };

  static (int, bool) _orderByHelper<O>(O? a, O? b) {
    if (a == null && b == null) return (0, true);
    if (a == null) return (-1, true);
    if (b == null) return (1, true);
    return (0, false);
  }
}
