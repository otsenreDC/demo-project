class Session {
  final String fullName;
  final Rol rol;
  final String userReference;

  Session(this.fullName, this.rol, this.userReference);

  bool get isSecretary {
    return rol == Rol.Secretary;
  }

  bool get isPatient {
    return rol == Rol.Patient;
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
