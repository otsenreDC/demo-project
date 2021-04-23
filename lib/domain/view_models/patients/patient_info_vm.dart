import 'package:email_validator/email_validator.dart';
import 'package:project_docere/domain/models/patient.dart';

class PatientInfoViewModel {
  String name;
  String lastName;
  String personalId;
  String phone;
  String email;

  bool get isComplete {
    final phoneIsValid = _validPhoneInput(phone);
    final emailIsValid = _validEmail(email);
    return name?.isNotEmpty == true &&
        lastName?.isNotEmpty == true &&
        personalId?.isNotEmpty == true &&
        phoneIsValid &&
        emailIsValid;
  }

  Patient getDetails() {
    return Patient(
      name: name.trim(),
      lastName: lastName.trim(),
      phone: phone.trim(),
      personalId: personalId.trim(),
      email: email.trim(),
    );
  }

  bool _validPhoneInput(String phone) {
    String pattern = r'^([0-9]{3}-[0-9]{3}-[0-9]{4})$';
    RegExp regExp = new RegExp(pattern);
    if (phone == null || phone.length == 0) {
      return false;
    }

    return regExp.hasMatch(phone);
  }

  bool _validEmail(String email) {
    if (email == null || email.isEmpty) {
      return false;
    }

    return EmailValidator.validate(email);
  }
}
