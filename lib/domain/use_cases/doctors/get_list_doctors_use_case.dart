import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/repositories/patient/patient_repository.dart';

class GetListDoctorsUseCase {
  IPatientRepository _patientRepository;

  GetListDoctorsUseCase(IPatientRepository patientRepository) {
    _patientRepository = patientRepository;
  }

  Future<List<Doctor>> execute(String patientId) async {
    final result = await _patientRepository.getDoctors();

    return result.fold(
      (exception) => List.empty(),
      (doctors) => doctors,
    );
  }
}
