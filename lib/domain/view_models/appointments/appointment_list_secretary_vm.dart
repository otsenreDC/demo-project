import 'package:flutter/cupertino.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/session.dart';
import 'package:project_docere/domain/use_cases/appointments/get_appointments_uc.dart';
import 'package:project_docere/domain/use_cases/doctors/get_secretary_doctors_uc.dart';

class AppointmentListSecretaryViewModel extends ChangeNotifier {
  Session _session;
  GetAppointmentsUseCase _appointmentsUseCase;
  GetSecretaryDoctorUseCase _getSecretaryDoctorUseCase;

  List<Appointment> _appointments;
  List<Doctor> _doctors;

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
    notifyListeners();
  }

  List<Doctor> get getDoctors {
    return _doctors;
  }

  int get doctorsCount {
    return _doctors == null ? 0 : _doctors.length;
  }

  void init() {
    // _loadAppointments();
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
    this._session,
    this._appointmentsUseCase,
    this._getSecretaryDoctorUseCase,
  );

  void _loadAppointments(String doctorReference) async {
    final result = await _appointmentsUseCase.execute();

    result.fold(
      (failure) => null,
      (appointments) {
        _setAppointments = appointments;
      },
    );
  }

  void _loadDoctors() async {
    final result =
        await _getSecretaryDoctorUseCase.execute(_session.userReference);

    _setDoctors = result.fold(
      (failure) => List.empty(),
      (doctors) => doctors,
    );
  }
}
