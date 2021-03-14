import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:project_docere/domain/models/secretary.dart';

final String _keyIdReference = "idReference";
final String _keyProfileReference = "profileReference";
final String _keyName = "name";
final String _keyPhone = "phone";

class SecretaryDTO {
  String idReference;
  String profileReference;

  String name;
  String phone;

  SecretaryDTO({
    @required this.idReference,
    @required this.profileReference,
    @required this.name,
    @required this.phone,
  });

  Secretary toDomain() {
    return Secretary(
      idReference: this.idReference,
      profileReference: profileReference,
      name: name,
      phone: phone,
    );
  }

  factory SecretaryDTO.fromJson(Map<String, dynamic> json) {
    final idReference = json[_keyIdReference] as DocumentReference;
    final profileReference = json[_keyProfileReference] as DocumentReference;

    return SecretaryDTO(
        idReference: idReference?.path,
        profileReference: profileReference?.path,
        name: json[_keyName],
        phone: json[_keyPhone]);
  }
}
