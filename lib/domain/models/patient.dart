class Patient {
  String idReference;
  String name;
  String lastName;
  String phone;
  String email;
  String personalId;

  Patient({
    this.idReference,
    this.name,
    this.lastName,
    this.phone,
    this.email,
    this.personalId,
  });

  String get fullName => "$name $lastName";
}
