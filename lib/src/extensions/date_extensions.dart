import 'package:intl/intl.dart';
import 'object_extensions.dart';

extension DateFormatEx on DateFormat {
  String formatNullDate(DateTime? date, [String nullReturnString = '-']) {
    if (date.isNull) return nullReturnString;
    return format(date!);
  }
}

extension DateExn on DateTime? {
  bool get isAfterNow {
    if (this == null) return false;
    return this!.isAfter(DateTime.now());
  }

  bool get isBeforeNow {
    if (this == null) return false;
    return this!.isBefore(DateTime.now());
  }

  bool isAfterNull(DateTime? other) {
    if (other == null) return true;
    if (this == null) return false;
    return this!.isAfter(other);
  }

  bool isBeforeNull(DateTime? other) {
    if (other == null) return true;
    if (this == null) return false;
    return this!.isBefore(other);
  }
}
