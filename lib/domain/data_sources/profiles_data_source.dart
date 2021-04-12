import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/models/profile.dart';

abstract class IProfilesDataSource {
  Either<Failure, Profile> getByCurrent();
  Future<Either<Failure, Profile>> getByEmail(String email);
  Future<Either<Failure, bool>> save(Profile profile);
}
