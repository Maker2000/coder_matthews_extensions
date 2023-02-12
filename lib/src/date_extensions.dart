import 'package:intl/intl.dart';

extension DateFormatEx on DateFormat {
  String formatNullDate(DateTime? date, [String nullReturnString = '-']) {
    if (date == null) return nullReturnString;
    return format(date);
  }
}
