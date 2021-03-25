import 'package:flutter/cupertino.dart';

class ProfileViewModel extends ChangeNotifier {
  bool _showAccountDetails = false;

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
}
