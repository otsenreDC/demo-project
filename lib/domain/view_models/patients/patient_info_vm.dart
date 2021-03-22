import 'package:project_docere/domain/models/patient.dart';

class PatientInfoViewModel {
  String name;
  String lastName;
  String personalId;
  String phone;

  bool get isComplete {
    return name?.isNotEmpty == true &&
        lastName?.isNotEmpty == true &&
        personalId?.isNotEmpty == true &&
        phone?.isNotEmpty == true;
  }

  Patient getDetails() {
    return Patient(
      name: name,
      lastName: lastName,
      phone: phone,
      personalId: personalId,
    );
  }
}
