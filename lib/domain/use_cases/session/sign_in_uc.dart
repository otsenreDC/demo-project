import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/services/session_service.dart';

class SignInUseCase {
  final ISessionService _sessionService;

  SignInUseCase(this._sessionService);

  Future<Either<Failure, bool>> execute(String email, String password) async {
    final signInResult = await _sessionService.signInWithEmail(email, password);

    return signInResult.fold(
      (failure) => Left(failure),
      (value) => Right(value),
    );
  }
}
