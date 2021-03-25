import 'package:flutter/foundation.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/session.dart';
import 'package:project_docere/domain/use_cases/doctors/get_list_doctors_use_case.dart';
import 'package:project_docere/domain/use_cases/doctors/get_secretary_doctors_uc.dart';
import 'package:project_docere/injection_container.dart';

class DoctorListViewModel extends ChangeNotifier {
  // final Session _session = currentTestSession;
  final GetListDoctorsUseCase _getPatientDoctorsUseCase;
  final GetSecretaryDoctorUseCase _getSecretaryDoctorUseCase;

  List<Doctor> _doctors;

  DoctorListViewModel(
    // this._session,
    this._getPatientDoctorsUseCase,
    this._getSecretaryDoctorUseCase,
  );

  set _setDoctors(List<Doctor> newValue) {
    _doctors = newValue;
    notifyListeners();
  }

  Rol get sessionRol {
    return currentTestSession.rol;
  }

  List<Doctor> get getDoctors {
    if (_doctors == null) {
      _loadDoctors();
      return List.empty();
    } else {
      return _doctors;
    }
  }

  void _loadDoctors() async {
    if (currentTestSession.isPatient) {
      final result = await _getPatientDoctorsUseCase.execute('42');
      if (result is List<Doctor>) {
        _setDoctors = result;
      } else {
        _setDoctors = List.empty();
      }
    } else if (currentTestSession.isSecretary) {
      final result = await _getSecretaryDoctorUseCase.execute(
        currentTestSession.userReference,
      );

      _setDoctors = result.fold(
        (failure) => List.empty(),
        (doctors) => doctors,
      );
    }
  }
}
