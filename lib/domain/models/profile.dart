import 'package:flutter/foundation.dart';

class Profile {
  final String id;
  final String email;
  final String role;
  final String name;
  final String lastName;

  Profile({
    @required this.id,
    @required this.email,
    @required this.role,
    @required this.name,
    @required this.lastName,
  });

  String get fullName => "$name $lastName";
}
