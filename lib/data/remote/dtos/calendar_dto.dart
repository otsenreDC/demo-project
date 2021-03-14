import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_docere/domain/models/calendar.dart';
import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/models/time.dart';

class CalendarDTO {
  CalendarDayDTO monday;
  CalendarDayDTO tuesday;
  CalendarDayDTO wednesday;
  CalendarDayDTO thursday;
  CalendarDayDTO friday;
  CalendarDayDTO saturday;
  CalendarDayDTO sunday;

  List<DayDTO> days;

  CalendarDTO({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  CalendarDTO.days(List<DayDTO> days) {
    this.days = days;
  }

  Calendar toDomain() {
    if (days != null) {
      return Calendar.days(days: _mapDaysToDomain());
    } else {
      return Calendar(
          monday: this.monday.toDomain(),
          tuesday: this.tuesday.toDomain(),
          wednesday: this.wednesday.toDomain(),
          thursday: this.thursday.toDomain(),
          friday: this.friday.toDomain(),
          saturday: this.saturday.toDomain(),
          sunday: this.sunday.toDomain());
    }
  }

  List<Day> _mapDaysToDomain() {
    try {
      return this.days?.map((DayDTO dto) => dto.toDomain())?.toList();
    } on Exception {
      return List.empty();
    }
  }

  factory CalendarDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return CalendarDTO(
      monday: CalendarDayDTO.fromJson(json["monday"]),
      tuesday: CalendarDayDTO.fromJson(json["tuesday"]),
      wednesday: CalendarDayDTO.fromJson(json["wednesday"]),
      thursday: CalendarDayDTO.fromJson(json["thursday"]),
      friday: CalendarDayDTO.fromJson(json["friday"]),
      saturday: CalendarDayDTO.fromJson(json["saturday"]),
      sunday: CalendarDayDTO.fromJson(json["sunday"]),
    );
  }
}

class CalendarDayDTO {
  int start;
  int end;
  bool workday;

  CalendarDayDTO({this.start, this.end, this.workday});

  CalendarDay toDomain() {
    return CalendarDay(
      start: Time.fromInt(start),
      end: Time.fromInt(end),
      workday: this.workday,
    );
  }

  factory CalendarDayDTO.fromJson(Map<String, dynamic> json) {
    return CalendarDayDTO(
      start: json["start"],
      end: json["end"],
      workday: json["workday"],
    );
  }
}

const String _keyWorkday = "workday";
const String _keyHoliday = "holiday";
const String _keySlots = "slots";

class DayDTO {
  String id;
  bool workday;
  bool holiday;
  List<DaySlotDTO> daySlots;

  DayDTO({this.id, this.workday, this.holiday, this.daySlots});

  factory DayDTO.fromJson(Map<String, dynamic> json) {
    Iterable days = json[_keySlots] as Iterable;

    return DayDTO(
      workday: json[_keyWorkday],
      holiday: json[_keyHoliday],
      daySlots: days?.map((day) => DaySlotDTO.fromJson(day))?.toList(),
    );
  }

  Map<String, dynamic> toJson(FirebaseFirestore firestore) {
    final daySlots = this.daySlots?.map((e) => e.toJson(firestore))?.toList();
    return Map.fromEntries([
      MapEntry(_keyHoliday, this.holiday),
      MapEntry(_keyWorkday, this.workday),
      MapEntry(
        _keySlots,
        daySlots,
      )
    ]);
  }

  Day toDomain() {
    return Day(
        id: int.tryParse(this?.id),
        holiday: this.holiday,
        workday: this.workday,
        daySlots: this.daySlots?.map((e) => e.toDomain())?.toList());
  }
}

const String _keyAppointmentReference = "appointmentReference";
const String _keyStart = "start";
const String _keyTaken = "taken";

class DaySlotDTO {
  String appointmentReference;
  bool taken;
  Timestamp start;

  DaySlotDTO({
    this.appointmentReference,
    this.start,
    this.taken,
  });

  factory DaySlotDTO.fromJson(Map<String, dynamic> json) {
    final DocumentReference appointmentReference =
        json[_keyAppointmentReference];

    return DaySlotDTO(
      appointmentReference: appointmentReference?.path,
      taken: json[_keyTaken],
      start: json[_keyStart],
    );
  }

  Map<String, dynamic> toJson(FirebaseFirestore _firestore) {
    final appointmentReference = this.appointmentReference != null
        ? _firestore.doc(this.appointmentReference)
        : null;
    return Map.fromEntries(
      [
        MapEntry(
          _keyAppointmentReference,
          appointmentReference,
        ),
        MapEntry(_keyStart, this.start),
        MapEntry(_keyTaken, this.taken)
      ],
    );
  }

  factory DaySlotDTO.fromDomain(DaySlot daySlot) {
    return DaySlotDTO(
        appointmentReference: daySlot.appointmentReference,
        start: daySlot.start,
        taken: daySlot.taken //daySlot.taken
        );
  }

  DaySlot toDomain() {
    return DaySlot(
      appointmentReference: this.appointmentReference,
      taken: this.taken,
      start: this.start,
    );
  }
}
