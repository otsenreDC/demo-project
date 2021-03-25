import 'center_info.dart';

class Doctor {
  String idReference;
  String profileReference;

  String name;
  String lastName;
  String specialty;

  String get fullName {
    return "$name $lastName";
  }

  List<CenterInfo> centerInfo;

  Doctor({
    this.idReference,
    this.profileReference,
    this.name,
    this.lastName,
    this.specialty,
    this.centerInfo,
  });

  @override
  String toString() {
    return "[$specialty] $name $lastName";
  }
}