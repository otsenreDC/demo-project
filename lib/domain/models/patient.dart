class Patient {
  String idReference;
  String name;
  String lastName;
  String phone;
  String personalId;

  Patient({
    this.idReference,
    this.name,
    this.lastName,
    this.phone,
    this.personalId,
  });

  String get fullName => "$name $lastName";
}
