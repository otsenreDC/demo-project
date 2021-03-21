import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/repositories/patient/appointment_repository.dart';

class GetDoctorAppointmentsUseCase {
  final IAppointmentRepository _appointmentRepository;

  GetDoctorAppointmentsUseCase(this._appointmentRepository);

  Future<Either<Failure, List<Appointment>>> execute(
      String doctorReference) async {
    final result = await _appointmentRepository.listByDoctor(doctorReference);

    return result.fold(
      (failure) => Left(failure),
      (appointments) => Right(appointments),
    );
  }
}
