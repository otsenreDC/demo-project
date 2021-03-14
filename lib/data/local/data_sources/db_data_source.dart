import 'dart:async';

import 'package:either_option/either_option.dart';
import 'package:project_docere/data/local/dtos/doctor_data.dart';
import 'package:project_docere/data/remote/dtos/calendar_dto.dart';
import 'package:project_docere/domain/data_sources/doctors_data_source.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/failure.dart';

class DoctorDatabaseDataSource extends IDoctorLocalDataSource {
  @override
  Future<List<Doctor>> list() {
    final completer = Completer<List<Doctor>>();

    final doctors = [DoctorData(name: "Juan")]
        .map(
          (e) => e.toDomain(),
        )
        .toList();

    completer.complete(doctors);

    return completer.future;
  }

  @override
  Future<CalendarDTO> getCalendar(
    String doctorId,
    String centerId,
    String calendarReference,
    int year,
  ) {
    final completer = Completer<CalendarDTO>();

    completer.complete(CalendarDTO());

    return completer.future;
  }

  @override
  Future<Either<Failure, bool>> updateDaySlot(String doctorIdReference,
      String calendarIdReference, DayDTO day, DaySlotDTO daySlot) {
    return Future.value(Right(true));
  }
}
