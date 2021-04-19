import 'package:flutter/cupertino.dart';
import 'package:project_docere/domain/models/profile.dart';
import 'package:project_docere/domain/routers/routes.dart';
import 'package:project_docere/domain/use_cases/doctors/get_current_profile_uc.dart';
import 'package:project_docere/domain/use_cases/session/sign_out_uc.dart';

class ProfileViewModel extends ChangeNotifier {
  bool _showAccountDetails = false;
  SignOutUseCase _signOutUseCase;
  GetCurrentProfileUseCase _getCurrentProfileUseCase;

  ProfileViewModel(
    this._signOutUseCase,
    this._getCurrentProfileUseCase,
  );

  set _setShowAccountDetails(bool newValue) {
    _showAccountDetails = newValue;
    notifyListeners();
  }

  bool get getShowAccountDetails {
    return _showAccountDetails;
  }

  Profile get getProfile {
    return this._getCurrentProfileUseCase.execute().fold(
          (failure) => null,
          (profile) => profile,
        );
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
