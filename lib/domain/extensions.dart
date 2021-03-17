import 'package:intl/intl.dart';

final String DATE_FORMAT_EXPRESSIVE = 'EEEE dd MMMM, yyyy';
final String DATE_FORMAT_TIME = 'hh:mm a';

class DateTimeHelper {
  static String format(DateTime date, {String pattern}) {
    if (date == null) return "NAD";

    if (pattern == null) return date.toIso8601String();

    final DateFormat formatter = DateFormat(pattern);

    return formatter.format(date);
  }
}
