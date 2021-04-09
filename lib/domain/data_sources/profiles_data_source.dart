import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/models/profile.dart';

abstract class IProfilesDataSource {
  Future<Either<Failure, Profile>> getByEmail(String email);
}
