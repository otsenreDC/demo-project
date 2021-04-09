import 'package:either_option/either_option.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/services/session_service.dart';

class SessionService with ISessionService {
  final FirebaseAuth _auth;

  SessionService(this._auth);

  @override
  Future<Either<Failure, bool>> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Right(true);
      // STORE DATA
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(UserNotRegisteredFailure());
      } else if (e.code == 'wrong-password') {
        return Left(WrongPasswordFailure());
      } else {
        return Left(UnknownSignInFailure(cause: e));
      }
    } catch (e) {
      return Left(UnknownSignInFailure());
    }
  }

  void authenticateWithFacebook() {}

  void authenticateWithGmail() {}

  void authenticateWithApple() {}
}
