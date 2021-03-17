import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:project_docere/data/remote/dtos/center_dto.dart';
import 'package:project_docere/domain/models/doctor.dart';

final String _keyIdReference = "idReference";
final String _keyProfileReference = "profileId";
final String _keyName = "name";
final String _keyLastName = "lastName";
final String _keySpecialty = "specialty";
final String _keyCenterInfo = "centroInfo";

class DoctorDTO {
  String id;
  String idReference;
  String profileReference;

  String name;
  String lastName;
  String specialty;

  List<CenterInfoDTO> centerInfo;

  DoctorDTO({
    @required this.id,
    @required this.idReference,
    @required this.profileReference,
    @required this.name,
    @required this.lastName,
    @required this.specialty,
    @required this.centerInfo,
  });

  Doctor toDomain() {
    String idReference;

    if (this.idReference?.isNotEmpty == true) {
      idReference = this.idReference;
    } else if (this.id?.isNotEmpty == true) {
      idReference = "doctores/${this.id}";
    } else {
      idReference = "";
    }

    return Doctor(
        idReference: idReference,
        profileReference: this.profileReference,
        name: this.name,
        lastName: this.lastName,
        specialty: this.specialty,
        centerInfo: this.centerInfo?.map((c) => c.toDomain())?.toList());
  }

  Map<String, dynamic> toJson() {
    return Map.fromEntries([
      MapEntry(_keyName, name),
      MapEntry(_keyLastName, lastName),
      MapEntry(_keySpecialty, specialty),
    ]);
  }

  factory DoctorDTO.fromDomain(Doctor doctor) {
    return DoctorDTO(
        id: null,
        idReference: doctor.idReference,
        profileReference: doctor.profileReference,
        name: doctor.name,
        lastName: doctor.lastName,
        specialty: doctor.specialty,
        centerInfo: null);
  }

  factory DoctorDTO.fromJson(String id, Map<String, dynamic> json) {
    if (json == null) return null;

    final idReference = json[_keyIdReference] as DocumentReference;
    final profileReference = json[_keyProfileReference] as DocumentReference;

    final Iterable centerInfo = json[_keyCenterInfo];

    return DoctorDTO(
      id: id,
      idReference: idReference?.path,
      profileReference: profileReference?.path,
      name: json[_keyName],
      lastName: json[_keyLastName],
      specialty: json[_keySpecialty],
      centerInfo: centerInfo
          ?.map((info) => CenterInfoDTO.fromJson(info as Map<String, dynamic>))
          ?.toList(),
    );
  }
}
