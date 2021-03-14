import 'package:project_docere/domain/models/calendar.dart';
import 'package:project_docere/domain/repositories/patient/doctor_repository.dart';

class GetCurrentCalendarUseCase {
  IDoctorRepository _doctorRepository;

  GetCurrentCalendarUseCase(IDoctorRepository doctorRepository) {
    _doctorRepository = doctorRepository;
  }

  Future<Calendar> execute(
    String doctorId,
    String centerId,
    String calendarReference,
  ) async {
    final result = await _doctorRepository.getCalendar(
      doctorId,
      centerId,
      calendarReference,
      2021,
    );

    return result.fold(
      (exception) => Calendar(),
      (calendar) => calendar,
    );
  }
}
