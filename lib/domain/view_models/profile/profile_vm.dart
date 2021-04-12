import 'package:flutter/cupertino.dart';
import 'package:project_docere/domain/routers/routes.dart';
import 'package:project_docere/domain/use_cases/session/sign_out_uc.dart';

class ProfileViewModel extends ChangeNotifier {
  bool _showAccountDetails = false;
  SignOutUseCase _signOutUseCase;

  ProfileViewModel(this._signOutUseCase);

  set _setShowAccountDetails(bool newValue) {
    _showAccountDetails = newValue;
    notifyListeners();
  }

  bool get getShowAccountDetails {
    return _showAccountDetails;
  }

  void showOptions() {
    _showAccountDetails = false;
    notifyListeners();
  }

  void showAccountDetails() {
    _setShowAccountDetails = true;
  }

  void signOut(BuildContext context) async {
    final result = await _signOutUseCase.execute();

    if (result) {
      Routes.popToLogin(context);
    } else {
      print("error cerrando sesión");
    }
  }
}
