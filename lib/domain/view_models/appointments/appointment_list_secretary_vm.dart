import 'package:flutter/cupertino.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/use_cases/doctors/get_doctor_appointments_uc.dart';
import 'package:project_docere/domain/use_cases/doctors/get_secretary_doctors_uc.dart';

class AppointmentListSecretaryViewModel extends ChangeNotifier {
  GetDoctorAppointmentsUseCase _getDoctorAppointmentsUseCase;
  GetSecretaryDoctorUseCase _getSecretaryDoctorUseCase;

  List<Appointment> _appointments;
  int _selectedDoctorPosition = 0;
  Doctor _doctor;
  DateTime _selectedDate = DateTime.now();

  init(Doctor doctor) async {
    _doctor = doctor;
    _loadAppointments(_doctor.idReference, DateTime.now());
  }

  void refresh(Doctor doctor) {
    if (_doctor == null || _doctor.idReference != doctor.idReference) {
      _doctor = doctor;
      loadAppointments(_selectedDate);
      notifyListeners();
    }
  }

  Appointment appointmentAt(int index) {
    if (_appointments == null || index >= _appointments.length) {
      return null;
    } else {
      return _appointments[index];
    }
  }

  AppointmentListSecretaryViewModel(
    this._getDoctorAppointmentsUseCase,
    this._getSecretaryDoctorUseCase,
  );

  void loadAppointments(DateTime date) {
    _loadAppointments(_doctor.idReference, date);
  }

  void _loadAppointments(String doctorReference, DateTime date) async {
    final result = await _getDoctorAppointmentsUseCase.execute(
      doctorReference,
      date,
    );

    result.fold(
      (failure) {
        print(failure);
      },
      (appointments) {
        _setAppointments = appointments;
      },
    );
  }

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

  set setSelectedDoctor(int position) {
    _selectedDoctorPosition = position;
    notifyListeners();
  }

  int get getSelectedDoctorPosition {
    return _selectedDoctorPosition;
  }

  bool get canCreateAppointment {
    return _doctor != null;
  }

  Doctor get getSelectedDoctor {
    return _doctor;
  }

  DateTime get getSelectedDate {
    return _selectedDate;
  }

  set setSelectedDate(DateTime dateTime) {
    _selectedDate = dateTime;
    notifyListeners();
  }
}
