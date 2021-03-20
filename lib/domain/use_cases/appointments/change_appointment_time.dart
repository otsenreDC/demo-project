import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/helpers/appointment_helper.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/repositories/patient/appointment_repository.dart';
import 'package:project_docere/domain/repositories/patient/doctor_repository.dart';

class ChangeAppointmentTimeUseCase {
  final IAppointmentRepository _appointmentRepository;
  final IDoctorRepository _doctorRepository;

  ChangeAppointmentTimeUseCase(
      this._appointmentRepository, this._doctorRepository);

  Future<Either<Failure, bool>> execute(
    Appointment appointment,
    Day day,
    DaySlot oldSlot,
    DaySlot newSlot,
  ) async {
    try {
      if (!oldSlot.inOrderOfArrival) {
        oldSlot.taken = false;
        oldSlot.appointmentReference = null;
        final resultFreeSlot = await _doctorRepository.updateDaySlot(
          appointment.doctor.idReference,
          appointment.centerInfo.calendarReference,
          day,
          oldSlot,
        );
        if (resultFreeSlot.isLeft) return Left(Failure());
      }
      if (!newSlot.inOrderOfArrival) {
        newSlot.taken = true;
        newSlot.appointmentReference = appointment.appointmentReference;
        final resultTakeSlot = await _doctorRepository.updateDaySlot(
          appointment.doctor.idReference,
          appointment.centerInfo.calendarReference,
          day,
          newSlot,
        );
        if (resultTakeSlot.isLeft) return Left(Failure());
      }

      final newAppointmentAt = _appointmentAtDate(
        newSlot,
        appointment.appointmentAt.toDate(),
      );
      final newAttentionOrder =
          AppointmentHelper.attentionOrder(newSlot.inOrderOfArrival);

      final updateResult = await _appointmentRepository.updateTime(
        appointment.appointmentReference,
        newAppointmentAt,
        newAttentionOrder,
      );

      appointment.attentionOrder = newAttentionOrder;
      appointment.appointmentAt = newAppointmentAt;

      return Right(true);
    } catch (e) {
      return Left(Failure());
    }
  }

  Timestamp _appointmentAtDate(DaySlot hour, DateTime day) {
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

    return Timestamp.fromDate(appointmentAt);
  }
}
