import 'package:flutter/foundation.dart';
import 'package:project_docere/domain/extensions.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/models/calendar.dart';
import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/repositories/patient/doctor_repository.dart';
import 'package:project_docere/domain/use_cases/appointments/change_appointment_time.dart';

class AppointmentEditViewModel extends ChangeNotifier {
  IDoctorRepository _doctorRepository;
  ChangeAppointmentTimeUseCase _changeAppointmentTimeUseCase;

  Appointment _appointment;
  DaySlot _newSlot;
  bool _confirmNewSlot = false;
  bool _updateDone = false;
  Calendar _calendar;

  AppointmentEditViewModel(
      this._doctorRepository, this._changeAppointmentTimeUseCase);

  void init(Appointment appointment) {
    _appointment = appointment;
    _loadCalendar();
  }

  bool get confirmNewSlot {
    return _confirmNewSlot;
  }

  bool get updateDone {
    return _updateDone;
  }

  set updateDone(bool done) {
    _updateDone = done;
    notifyListeners();
  }

  DateTime get currentTime {
    return _appointment?.appointmentAt?.toDate();
  }

  DateTime get newTime {
    return _newSlot.startInDateTime();
  }

  set newSlot(DaySlot daySlot) {
    _confirmNewSlot = true;
    _newSlot = daySlot;
    notifyListeners();
  }

  DaySlot get newSlot {
    return _newSlot;
  }

  bool get isInOrderOfArrival {
    return _appointment.isAttentionOnOrderOfArrival == true;
  }

  set calendar(Calendar calendar) {
    this._calendar = calendar;
    notifyListeners();
  }

  Day get getDay {
    final appointmentAt = this._appointment.appointmentAt.toDate();
    final day = appointmentAt.dayOfYear;
    if (_calendar == null)
      return null;
    else
      return _calendar?.days?.firstWhere((element) => element.id == day);
  }

  void cancelConfirmation() {
    _confirmNewSlot = false;
    _newSlot = null;
    notifyListeners();
  }

  void changeTime() async {
    Day day = getDay;
    DaySlot oldSlot;

    if (_appointment.attentionOrder == "hour") {
      oldSlot = day.daySlots.firstWhere((element) => element.taken);
    } else {
      oldSlot = DaySlot.inOrderOfArrival();
    }

    final result = await _changeAppointmentTimeUseCase.execute(
      _appointment,
      day,
      oldSlot,
      newSlot,
    );

    result.fold(
      (failure) => _handleError(),
      (result) => updateDone = true,
    );
  }

  void _loadCalendar() async {
    final result = await _doctorRepository.getCalendar(
        _appointment.doctor.idReference,
        _appointment.centerInfo.idReference,
        _appointment.centerInfo.calendarReference,
        2021);

    result.fold((failure) => print(failure), (result) => calendar = result);
  }

  void _handleError() {}
}
