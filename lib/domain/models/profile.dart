import 'package:flutter/foundation.dart';

class Profile {
  final String id;
  final String email;
  final String role;
  final String name;
  final String lastName;
  final String personalId;
  final String phone;
  final DateTime birthday;

  Profile({
    @required this.id,
    @required this.email,
    @required this.role,
    @required this.name,
    @required this.lastName,
    @required this.personalId,
    @required this.phone,
    @required this.birthday,
  });

  String get fullName => "$name $lastName";
}
