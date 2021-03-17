import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/repositories/patient/appointment_repository.dart';

class GetAppointmentsUseCase {
  IAppointmentRepository _appointmentRepository;

  GetAppointmentsUseCase(IAppointmentRepository appointmentRepository) {
    this._appointmentRepository = appointmentRepository;
  }

  Future<Either<Failure, List<Appointment>>> execute() async {
    return await _appointmentRepository.list();
  }
}
