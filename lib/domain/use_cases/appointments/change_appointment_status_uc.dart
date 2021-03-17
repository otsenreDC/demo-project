import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/repositories/patient/appointment_repository.dart';

class ChangeAppointmentStatusUseCase {
  final IAppointmentRepository _appointmentRepository;

  ChangeAppointmentStatusUseCase(this._appointmentRepository);

  Future<Either<Failure, bool>> execute(
    String appointmentReference,
    AppointmentStatus newStatus,
  ) async {
    try {
      final result = await _appointmentRepository.updateStatus(
          appointmentReference, newStatus);

      return result.fold(
        (failure) => Left(Failure()),
        (bool) => Right(bool),
      );
    } catch (e) {
      return Left(Failure());
    }
  }
}
