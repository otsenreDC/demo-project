import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/models/ui_state.dart';
import 'package:project_docere/domain/routers/routes.dart';
import 'package:project_docere/domain/services/session_service.dart';

class LoginViewModel extends ChangeNotifier {
  final ISessionService _sessionService;
  final BuildContext _buildContext;

  UIState _uiState = UIShowData();
  String _email;
  String _password;

  LoginViewModel(this._sessionService, this._buildContext);

  void signIn() async {
    _setUIState = UILoading();
    final result = await _sessionService.signInWithEmail(_email, _password);

    result.fold(_handleSignInError, _handleSignInSuccess);
    print(result);
  }

  void _handleSignInSuccess(bool value) {
    if (value) {
      Routes.goHome(_buildContext);
    } else {
      _setUIError = "Error procesando los datos";
    }
  }

  void _handleSignInError(Failure failure) {
    if (failure is UserNotRegisteredFailure) {
      _setUIError = "Usuario y/o contraseña incorrectos";
    } else if (failure is WrongPasswordFailure) {
      _setUIError = "Usuario y/o contraseña incorrectos";
    } else if (failure is UnknownSignInFailure) {
      _setUIError = "Error conectando con el servidor";
    } else {
      _setUIError = "Se ha producido un error";
    }
  }

  UIState get getUIState {
    return _uiState;
  }

  set _setUIError(String message) {
    _setUIState = UIError(message: message);
  }

  set _setUIState(UIState newState) {
    _uiState = newState;
    notifyListeners();
  }

  set setEmail(String newValue) {
    this._email = newValue;
  }

  set setPassword(String newValue) {
    this._password = newValue;
  }
}
