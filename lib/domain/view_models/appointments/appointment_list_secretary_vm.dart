import 'package:flutter/cupertino.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/use_cases/doctors/get_doctor_appointments_uc.dart';
import 'package:project_docere/domain/use_cases/doctors/get_secretary_doctors_uc.dart';
import 'package:project_docere/injection_container.dart';

class AppointmentListSecretaryViewModel extends ChangeNotifier {
  // Session _session = currentTestSession;
  GetDoctorAppointmentsUseCase _getDoctorAppointmentsUseCase;
  GetSecretaryDoctorUseCase _getSecretaryDoctorUseCase;

  List<Appointment> _appointments;
  List<Doctor> _doctors;
  int _selectedDoctorPosition = 0;

  set _setAppointments(List<Appointment> appointments) {
    _appointments = appointments;
    notifyListeners();
  }

  List<Appointment> get getAppointments {
    return _appointments;
  }

  int get appointmentCount {
    return _appointments == null ? 0 : _appointments.length;
  }

  set _setDoctors(List<Doctor> doctors) {
    _doctors = doctors;
    if (doctors.isNotEmpty) {
      _loadAppointments(doctors.first.idReference);
    }
    notifyListeners();
  }

  List<Doctor> get getDoctors {
    return _doctors;
  }

  int get doctorsCount {
    return _doctors == null ? 0 : _doctors.length;
  }

  set setSelectedDoctor(int position) {
    _selectedDoctorPosition = position;
    notifyListeners();
  }

  int get getSelectedDoctorPosition {
    return _selectedDoctorPosition;
  }

  bool get canCreateAppointment {
    return _selectedDoctorPosition != null &&
        _doctors?.isNotEmpty == true &&
        _selectedDoctorPosition >= 0 &&
        _selectedDoctorPosition <= _doctors.length;
  }

  Doctor get getSelectedDoctor {
    try {
      return _selectedDoctorPosition == null
          ? null
          : _doctors[_selectedDoctorPosition];
    } catch (e) {
      return null;
    }
  }

  void init() {
    _loadDoctors();
  }

  Appointment appointmentAt(int index) {
    if (_appointments == null || index >= _appointments.length) {
      return null;
    } else {
      return _appointments[index];
    }
  }

  Doctor doctorAt(int index) {
    if (_doctors == null || index >= _doctors.length) {
      return null;
    } else {
      return _doctors[index];
    }
  }

  AppointmentListSecretaryViewModel(
    // this._session,
    this._getDoctorAppointmentsUseCase,
    this._getSecretaryDoctorUseCase,
  );

  void _loadAppointments(String doctorReference) async {
    final result = await _getDoctorAppointmentsUseCase.execute(doctorReference);

    result.fold(
      (failure) => null,
      (appointments) {
        _setAppointments = appointments;
      },
    );
  }

  void _loadDoctors() async {
    final result = await _getSecretaryDoctorUseCase
        .execute(currentTestSession.userReference);

    _setDoctors = result.fold(
      (failure) => List.empty(),
      (doctors) => doctors,
    );
  }
}
