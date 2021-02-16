import 'package:project_docere/domain/repositories/patient/patient_repository.dart';

class GetPatientDoctorsUseCase {
  IPatientRepository _patientRepository;

  GetPatientDoctorsUseCase(IPatientRepository patientRepository) {
    _patientRepository = patientRepository;
  }

  bool execute() {
    return true;
  }
}
