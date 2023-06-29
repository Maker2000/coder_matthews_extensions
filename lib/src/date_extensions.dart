import 'package:intl/intl.dart';
import './object_extensions.dart';

extension DateFormatEx on DateFormat {
  String formatNullDate(DateTime? date, [String nullReturnString = '-']) {
    if (date.isNull) return nullReturnString;
    return format(date!);
  }
}
