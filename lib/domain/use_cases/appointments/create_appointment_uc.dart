import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/repositories/patient/appointment_repository.dart';
import 'package:project_docere/domain/repositories/patient/doctor_repository.dart';

class CreateAppointmentUseCase {
  IAppointmentRepository _appointmentRepository;
  IDoctorRepository _doctorRepository;

  CreateAppointmentUseCase(
    IAppointmentRepository appointmentRepository,
    IDoctorRepository doctorRepository,
  ) {
    this._appointmentRepository = appointmentRepository;
    this._doctorRepository = doctorRepository;
  }

  Future<Either<Failure, bool>> execute(
    String centerProfileReference,
    String doctorProfileReference,
    String calendarReference,
    String secretaryProfileReference,
    String patientProfileReference,
    bool inOrderOfArrival,
    Day day,
    DaySlot slot,
    DateTime selectedDateTime,
  ) async {
    final createAppointmentResult = await _appointmentRepository.create(
      centerProfileReference,
      doctorProfileReference,
      secretaryProfileReference,
      patientProfileReference,
      inOrderOfArrival ? "order" : "hour",
      _appointmentAtDate(slot, selectedDateTime),
      "",
    );

    Either<Failure, bool> updateDoctorResult;

    if (!slot.inOrderOfArrival) {
      updateDoctorResult = await _doctorRepository.updateDaySlot(
        doctorProfileReference,
        calendarReference,
        day,
        slot,
      );
    }

    if (createAppointmentResult.isRight &&
        (updateDoctorResult == null || updateDoctorResult?.isRight == true)) {
      return Right(true);
    } else {
      return Left(Failure());
    }
  }

  DateTime _appointmentAtDate(DaySlot hour, DateTime day) {
    final slotDateTime = hour.startInDateTime();
    final appointmentAt = DateTime(
      day.year,
      day.month,
      day.day,
      slotDateTime.hour,
      slotDateTime.minute,
      slotDateTime.second,
      0,
    );

    return appointmentAt;
  }
}
