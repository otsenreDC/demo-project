import 'package:project_docere/domain/models/doctor.dart';

final String _keyProfileId = "profileId";
final String _keyName = "name";
final String _keyLastName = "lastName";
final String _keySpecialty = "specialty";

class DoctorDTO {
  String profileId;

  String name;
  String lastName;
  String specialty;

  DoctorDTO({
    this.profileId,
    this.name,
    this.lastName,
    this.specialty,
  });

  Doctor toDomain() {
    return Doctor(
      profileId: this.profileId,
      name: this.name,
      lastName: this.lastName,
      specialty: this.specialty,
    );
  }

  factory DoctorDTO.fromJson(Map<String, dynamic> json) {
    return DoctorDTO(
      profileId: json[_keyProfileId].toString(),
      name: json[_keyName],
      lastName: json[_keyLastName],
      specialty: json[_keySpecialty],
    );
  }
}
