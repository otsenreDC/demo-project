import 'package:flutter/cupertino.dart';
import 'package:project_docere/domain/models/profile.dart';

class ProfileDTO {
  static final String _keyEmail = "email";
  static final String _keyRole = "role";
  static final String _keyName = "name";
  static final String _keyLastName = "last_name";

  final String id;
  final String email;
  final String role;
  final String name;
  final String lastName;

  ProfileDTO({
    @required this.id,
    @required this.email,
    @required this.role,
    @required this.name,
    @required this.lastName,
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
    );
  }

  Profile toDomain() {
    return Profile(
      id: id,
      email: email,
      role: role,
      name: name,
      lastName: lastName,
    );
  }
}
