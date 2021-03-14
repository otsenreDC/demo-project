import 'package:project_docere/domain/models/calendar.dart';
import 'package:project_docere/domain/models/secretary.dart';

class CenterInfo {
  String idReference;
  String profileReference;
  String name;
  String address;

  List<Secretary> secretaries;
  String calendarReference;
  Calendar calendar;

  CenterInfo({
    this.idReference,
    this.profileReference,
    this.name,
    this.address,
    this.secretaries,
    this.calendar,
    this.calendarReference,
  });
}
