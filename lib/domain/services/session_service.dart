import 'package:either_option/either_option.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_docere/domain/models/failure.dart';

abstract class ISessionService {
  Future<Either<Failure, bool>> signInWithEmail(
    String email,
    String password,
  );

  Future<Either<Failure, User>> getUser(
    String email,
  );
}
