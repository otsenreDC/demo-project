import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_docere/domain/models/patient.dart';

const String _keyIdReference = "idReference";
const String _keyName = "name";
const String _keyLastName = "lastName";
const String _keyPhone = "phone";
const String _keyEmail = "email";
const String _keyPersonalId = "personalId";

class PatientDTO {
  String idReference;
  String name;
  String lastName;
  String phone;
  String email;
  String personalId;

  PatientDTO({
    this.idReference,
    this.name,
    this.lastName,
    this.phone,
    this.email,
    this.personalId,
  });

  factory PatientDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    DocumentReference reference;
    try {
      reference = json[_keyIdReference] as DocumentReference;
    } catch (e) {
      reference = null;
    }

    return PatientDTO(
      idReference: reference?.path,
      name: json[_keyName],
      lastName: json[_keyLastName],
      phone: json[_keyPhone],
      personalId: json[_keyPersonalId],
      email: json[_keyEmail],
    );
  }

  Map<String, dynamic> toJson(FirebaseFirestore firestore) {
    return Map.fromEntries(
      [
        MapEntry(_keyIdReference,
            idReference != null ? firestore.doc(idReference) : null),
        MapEntry(_keyName, name),
        MapEntry(_keyLastName, lastName),
        MapEntry(_keyPhone, phone),
        MapEntry(_keyEmail, email),
        MapEntry(_keyPersonalId, personalId),
      ],
    );
  }

  Patient toDomain() {
    return Patient(
      idReference: this.idReference,
      name: this.name,
      lastName: this.lastName,
      phone: this.phone,
      personalId: this.personalId,
      email: this.email,
    );
  }

  factory PatientDTO.fromDomain(Patient patient) {
    return PatientDTO(
      idReference: patient.idReference,
      name: patient.name,
      lastName: patient.lastName,
      phone: patient.phone,
      personalId: patient.personalId,
      email: patient.email,
    );
  }
}
