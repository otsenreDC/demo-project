import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/helpers/appointment_helper.dart';
import 'package:project_docere/domain/models/center_info.dart';
import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/models/patient.dart';
import 'package:project_docere/domain/models/secretary.dart';
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
    CenterInfo centerInfo,
    Doctor doctor,
    String calendarReference,
    Secretary secretary,
    Patient patient,
    bool inOrderOfArrival,
    Day day,
    DaySlot slot,
    DateTime selectedDateTime,
  ) async {
    final createAppointmentResult = await _appointmentRepository.create(
      centerInfo,
      doctor,
      secretary,
      patient,
      AppointmentHelper.attentionOrder(inOrderOfArrival),
      _appointmentAtDate(slot, selectedDateTime),
      "",
    );

    Either<Failure, bool> updateDoctorResult;

    if (!slot.inOrderOfArrival) {
      updateDoctorResult = await _doctorRepository.updateDaySlot(
        doctor.idReference,
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
    if (hour.inOrderOfArrival) return null;

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
