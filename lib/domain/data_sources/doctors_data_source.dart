import 'package:either_option/either_option.dart';
import 'package:project_docere/data/remote/dtos/calendar_dto.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/failure.dart';

abstract class IDoctorDataSource {
  Future<List<Doctor>> list();

  Future<CalendarDTO> getCalendar(
    String doctorId,
    String centerId,
    String calendarReference,
    int year,
  );

  Future<Either<Failure, bool>> updateDaySlot(
    String doctorIdReference,
    String calendarIdReference,
    DayDTO day,
    DaySlotDTO daySlot,
  );
}

abstract class IDoctorRemoteDataSource extends IDoctorDataSource {}

abstract class IDoctorLocalDataSource extends IDoctorDataSource {}
