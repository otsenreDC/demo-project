import 'package:flutter/cupertino.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/use_cases/appointments/get_appointments_uc.dart';

class AppointmentListViewModel extends ChangeNotifier {
  GetAppointmentsUseCase _appointmentsUseCase;

  List<Appointment> _appointments;

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

  Appointment appointmentAt(int index) {
    if (_appointments == null || index >= _appointments.length) {
      return null;
    } else {
      return _appointments[index];
    }
  }

  AppointmentListViewModel(GetAppointmentsUseCase appointmentsUseCase) {
    this._appointmentsUseCase = appointmentsUseCase;
  }

  void loadAppointments() async {
    final result = await _appointmentsUseCase.execute();

    result.fold(
      (failure) => null,
      (appointments) {
        _setAppointments = appointments;
      },
    );
  }
}
