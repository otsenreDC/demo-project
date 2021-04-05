import 'package:project_docere/domain/models/patient.dart';

class PatientInfoViewModel {
  String name;
  String lastName;
  String personalId;
  String phone;
  String email;

  bool get isComplete {
    return name?.isNotEmpty == true &&
        lastName?.isNotEmpty == true &&
        personalId?.isNotEmpty == true &&
        phone?.isNotEmpty == true &&
        email?.isNotEmpty == true;
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
}
