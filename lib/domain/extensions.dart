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

extension DateTimeExt on DateTime {
  int get dayOfYear {
    return this.difference(DateTime(this.year, 1, 1, 0, 0)).inDays;
  }

  bool isToday() {
    final now = DateTime.now();
    return this.year == now.year &&
        this.month == now.month &&
        this.day == now.day;
  }
}
