import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/models/time.dart';

class Calendar {
  CalendarDay monday;
  CalendarDay tuesday;
  CalendarDay wednesday;
  CalendarDay thursday;
  CalendarDay friday;
  CalendarDay saturday;
  CalendarDay sunday;

  List<Day> days;

  Calendar({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  Calendar.days({this.days});
}

class CalendarDay {
  Time start;
  Time end;
  bool workday;

  CalendarDay({this.start, this.end, this.workday});
}
