import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/repositories/patient/doctor_repository.dart';

class GetSecretaryDoctorUseCase {
  final IDoctorRepository _doctorRepository;

  GetSecretaryDoctorUseCase(this._doctorRepository);

  Future<Either<Failure, List<Doctor>>> execute(
      String secretaryReference) async {
    try {
      final result =
          await _doctorRepository.getSecretaryDoctors(secretaryReference);

      return result.fold(
        (failure) => Left(failure),
        (doctors) => Right(doctors),
      );
    } catch (e) {
      return Left(Failure(cause: e));
    }
  }
}
