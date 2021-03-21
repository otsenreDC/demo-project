class Patient {
  String idReference;
  String name;
  String lastName;

  Patient({this.idReference, this.name, this.lastName});

  String get fullName => "$name $lastName";
}
