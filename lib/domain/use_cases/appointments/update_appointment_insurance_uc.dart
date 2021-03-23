import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/models/insurance.dart';
import 'package:project_docere/domain/repositories/patient/appointment_repository.dart';

class UpdateAppointmentInsuranceUseCase {
  final IAppointmentRepository _appointmentRepository;

  UpdateAppointmentInsuranceUseCase(this._appointmentRepository);

  Future<Either<Failure, bool>> execute(
      String appointmentReference, Insurance insurance) async {
    return await _appointmentRepository.updateInsurance(
      appointmentReference,
      insurance,
    );
  }
}
