class Session {
  final String fullName;
  final Rol role;
  final String userReference;
  final String authentication;

  Session(this.fullName, this.role, this.userReference, {this.authentication});

  bool get isSecretary {
    return role == Rol.Secretary;
  }

  bool get isPatient {
    return role == Rol.Patient;
  }
}

class PatientSessionTmp extends Session {
  PatientSessionTmp()
      : super(
          "Pedro Peréz",
          Rol.Patient,
          "secretarias/qIjJkG4nkydOJ4woSMwx",
        );
}

class SecretarySessionTmp extends Session {
  SecretarySessionTmp()
      : super(
          "Juana de Arco",
          Rol.Secretary,
          "secretarias/qIjJkG4nkydOJ4woSMwx",
        );
}

enum Rol { Patient, Secretary }

Rol roleFromString(String input) {
  if (input.toLowerCase() == "secretary") {
    return Rol.Secretary;
  } else
    return Rol.Patient;
}
