import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_docere/domain/models/patient.dart';

const String _keyIdReference = "idReference";
const String _keyName = "name";
const String _keyLastName = "lastName";

class PatientDTO {
  String idReference;
  String name;
  String lastName;

  PatientDTO({this.idReference, this.name, this.lastName});

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
    );
  }

  Map<String, dynamic> toJson(FirebaseFirestore firestore) {
    return Map.fromEntries(
      [
        MapEntry(_keyIdReference,
            idReference != null ? firestore.doc(idReference) : null),
        MapEntry(_keyName, name),
        MapEntry(_keyLastName, lastName),
      ],
    );
  }

  Patient toDomain() {
    return Patient(
      idReference: this.idReference,
      name: this.name,
      lastName: this.lastName,
    );
  }

  factory PatientDTO.fromDomain(Patient patient) {
    return PatientDTO(
      idReference: patient.idReference,
      name: patient.name,
      lastName: patient.lastName,
    );
  }
}
