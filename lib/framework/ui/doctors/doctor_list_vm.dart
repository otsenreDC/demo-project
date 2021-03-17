import 'package:flutter/foundation.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/use_cases/doctors/get_list_doctors_use_case.dart';

class DoctorListViewModel extends ChangeNotifier {
  final GetListDoctorsUseCase _getPatientDoctorsUseCase;

  List<Doctor> _doctors;

  DoctorListViewModel(this._getPatientDoctorsUseCase);

  set _setDoctors(List<Doctor> newValue) {
    _doctors = newValue;
    notifyListeners();
  }

  List<Doctor> get getDoctors {
    if (_doctors == null) {
      _loadDoctors();
      return List.empty();
    } else {
      return _doctors;
    }
  }

  void _loadDoctors() {
    _getPatientDoctorsUseCase.execute('42').then(
          (value) => {
            if (value is List<Doctor>)
              {
                _setDoctors = value,
              }
            else
              {
                _setDoctors = List.empty(),
              }
          },
        );
  }
}
