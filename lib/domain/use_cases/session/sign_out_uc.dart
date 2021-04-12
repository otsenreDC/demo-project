import 'package:project_docere/domain/services/session_service.dart';

class SignOutUseCase {
  final ISessionService _sessionService;

  SignOutUseCase(this._sessionService);

  Future<bool> execute() async {
    return (await _sessionService.signOut()).fold(
      (failure) => false,
      (value) => value,
    );
  }
}
