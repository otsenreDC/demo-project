import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/models/ui_state.dart';
import 'package:project_docere/domain/routers/routes.dart';
import 'package:project_docere/domain/use_cases/session/sign_in_uc.dart';
import 'package:project_docere/domain/use_cases/session/validate_session_uc.dart';

class LoginViewModel extends ChangeNotifier {
  final SignInUseCase _signInUseCase;
  final ValidateSessionUseCase _validateSessionUseCase;
  final BuildContext _buildContext;

  UIState _uiState = UILoading();
  String _email;
  String _password;

  LoginViewModel(
    this._signInUseCase,
    this._validateSessionUseCase,
    this._buildContext,
  );

  validateSession() {
    try {
      final result = _validateSessionUseCase.execute();

      result.fold((failure) {
        _setUIState = UIShowData();
      }, (value) {
        if (value) {
          Routes.goHome(_buildContext);
        } else {
          _setUIState = UIShowData();
        }
      });
    } catch (e) {
      _setUIState = UIShowData();
    }
  }

  void signIn() async {
    _setUIState = UILoading();
    final result = await _signInUseCase.execute(_email, _password);

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
