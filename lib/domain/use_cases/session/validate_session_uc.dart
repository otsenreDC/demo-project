import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/services/session_service.dart';

class ValidateSessionUseCase {
  final ISessionService _sessionService;

  ValidateSessionUseCase(this._sessionService);

  Either<Failure, bool> execute() {
    final result = _sessionService.getSession();

    return result.fold(
      (failure) => Left(failure),
      (value) => Right(value != null),
    );
  }
}
