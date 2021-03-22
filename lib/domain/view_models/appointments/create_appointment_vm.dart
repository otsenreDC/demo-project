import 'package:flutter/cupertino.dart';
import 'package:project_docere/domain/models/calendar.dart';
import 'package:project_docere/domain/models/center_info.dart';
import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/patient.dart';
import 'package:project_docere/domain/models/session.dart';
import 'package:project_docere/domain/use_cases/doctors/get_current_calendar_uc.dart';

class CreateAppointmentViewModel extends ChangeNotifier {
  Session _session;
  GetCurrentCalendarUseCase _getCurrentCalendarUseCase;

  CreateAppointmentViewModel(
    this._session,
    this._getCurrentCalendarUseCase,
  );

  Doctor _doctor;
  CenterInfo _selectedCenter;
  Patient _patient;

  Day _selectedDate;
  DaySlot _selectedHour;
  DateTime _selectedDateTime;

  CalendarStatus _calendarStatus = CalendarStatus(false, false, null);

  void start(Doctor doctor) {
    this._doctor = doctor;
    if (_session.isPatient) {
      _patient = Patient(
        lastName: "Guzmán",
        name: "Luis",
        idReference: "pacientes/tiJAkHwEm1qh7wh4eEj2",
      );
    }
    notifyListeners();
  }

  bool get needPatientInfo {
    return _patient == null;
  }

  set setPatient(Patient patient) {
    _patient = patient;
    notifyListeners();
  }

  Patient get getPatient {
    return _patient;
  }

  set setSelectedDate(Day value) {
    _selectedDate = value;
    notifyListeners();
  }

  Day get getSelectedDate {
    return _selectedDate;
  }

  set setDoctor(Doctor doctor) {
    _doctor = doctor;
  }

  Doctor get getDoctor {
    return _doctor;
  }

  set setSelectedCenter(CenterInfo centerInfo) {
    _selectedCenter = centerInfo;
    loadCalendar(centerInfo.idReference, centerInfo.calendarReference);
    notifyListeners();
  }

  CenterInfo get getSelectedCenter {
    return _selectedCenter;
  }

  set _setCalendarStatus(CalendarStatus getCalendarStatus) {
    _calendarStatus = getCalendarStatus;
    notifyListeners();
  }

  CalendarStatus get getCalendarStatus {
    return _calendarStatus;
  }

  bool centerIsSelected(CenterInfo center) {
    return center == _selectedCenter;
  }

  set setSelectedHour(DaySlot value) {
    _selectedHour = value.copy();
    _selectedHour.taken = true;
    // notifyListeners();
  }

  DaySlot get getSelectedHour {
    return _selectedHour;
  }

  set setSelectedDateTime(DateTime value) {
    _selectedDateTime = value;
  }

  DateTime get getSelectedDateTime {
    return _selectedDateTime;
  }

  void loadCalendar(
    String centerId,
    String calendarReference,
  ) {
    _setCalendarStatus = CalendarStatus(false, true, null);
    _getCurrentCalendarUseCase
        .execute(
          _doctor.idReference,
          centerId,
          calendarReference,
        )
        .then(
          (value) => {
            if (value is Calendar)
              {
                _setCalendarStatus = CalendarStatus(false, false, value),
              }
            else
              {
                _setCalendarStatus = CalendarStatus(false, true, null),
              }
          },
        );
  }
}

class CalendarStatus {
  final bool error;
  final bool loading;
  final Calendar data;

  CalendarStatus(this.error, this.loading, this.data);
}
