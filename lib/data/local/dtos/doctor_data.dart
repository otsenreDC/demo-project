import 'package:project_docere/domain/models/doctor.dart';

class DoctorData {
  String code;
  String name;
  String specialty;

  DoctorData({
    this.code,
    this.name,
    this.specialty,
  });

  Doctor toDomain() {
    return Doctor(
      profileReference: this.code,
      name: this.name,
      specialty: this.specialty,
    );
  }
}
