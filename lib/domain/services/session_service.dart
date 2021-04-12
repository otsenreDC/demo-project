import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/models/profile.dart';
import 'package:project_docere/domain/models/session.dart';

abstract class ISessionService {
  Future<Either<Failure, bool>> signInWithEmail(
    String email,
    String password,
  );
  Future<Either<Failure, bool>> signOut();

  Future<Either<Failure, bool>> saveProfile(Profile profile);

  Either<Failure, Session> getSession();

  Future<Either<Failure, Profile>> getUser(
    String email,
  );
}
