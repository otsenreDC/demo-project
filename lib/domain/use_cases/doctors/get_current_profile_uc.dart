import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/models/profile.dart';
import 'package:project_docere/domain/services/session_service.dart';

class GetCurrentProfileUseCase {
  ISessionService _sessionService;

  GetCurrentProfileUseCase(this._sessionService);

  Either<Failure, Profile> execute() {
    return _sessionService.getCurrent().fold(
          (failure) => Left(failure),
          (profile) => Right(profile),
        );
  }
}
