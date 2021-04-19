import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_docere/domain/models/profile.dart';

class ProfileDTO {
  static final String _keyEmail = "email";
  static final String _keyRole = "role";
  static final String _keyName = "name";
  static final String _keyLastName = "lastName";
  static final String _keyPersonalId = "personalId";
  static final String _keyPhone = "phone";
  static final String _keyBirthday = "birthday";

  final String id;
  final String email;
  final String role;
  final String name;
  final String lastName;
  final String personalId;
  final String phone;
  final Timestamp birthday;

  ProfileDTO({
    @required this.id,
    @required this.email,
    @required this.role,
    @required this.name,
    @required this.lastName,
    @required this.personalId,
    @required this.phone,
    @required this.birthday,
  });

  factory ProfileDTO.fromJson({
    @required String id,
    Map<String, dynamic> json,
  }) {
    return ProfileDTO(
      id: id,
      email: json[_keyEmail],
      role: json[_keyRole],
      name: json[_keyName],
      lastName: json[_keyLastName],
      personalId: json[_keyPersonalId],
      phone: json[_keyPhone],
      birthday: json[_keyBirthday],
    );
  }

  Profile toDomain() {
    return Profile(
      id: id,
      email: email,
      role: role,
      name: name,
      lastName: lastName,
      personalId: personalId,
      phone: phone,
      birthday: birthday != null ? birthday.toDate() : null,
    );
  }
}
