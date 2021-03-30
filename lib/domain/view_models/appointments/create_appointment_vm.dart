import 'package:flutter/cupertino.dart';
import 'package:project_docere/domain/models/calendar.dart';
import 'package:project_docere/domain/models/center_info.dart';
import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/patient.dart';
import 'package:project_docere/domain/use_cases/doctors/get_current_calendar_uc.dart';
import 'package:project_docere/injection_container.dart';

class CreateAppointmentViewModel extends ChangeNotifier {
  // Session _session = currentTestSession;
  GetCurrentCalendarUseCase _getCurrentCalendarUseCase;

  CreateAppointmentViewModel(
    // this._session,
    this._getCurrentCalendarUseCase,
  );

  Function _onConfirm;

  Doctor _doctor;
  CenterInfo _selectedCenter;
  Patient _patient;
  Day _selectedDay;
  DaySlot _selectedDaySlot;
  DateTime _selectedHour;
  bool _showPatientInfo = false;

  CalendarStatus _calendarStatus = CalendarStatus(false, false, null);

  bool centerIsSelected(CenterInfo center) {
    return center == _selectedCenter;
  }

  void start(Doctor doctor, Function onConfirm) {
    _showPatientInfo = false;
    _onConfirm = onConfirm;
    this._doctor = doctor;
    if (currentTestSession.isPatient) {
      _patient = Patient(
        lastName: "Guzmán",
        name: "Luis",
        idReference: "pacientes/tiJAkHwEm1qh7wh4eEj2",
      );
    }
    notifyListeners();
  }

  void confirmInspection(Day day, DaySlot slot, DateTime dateTime) {
    _selectedDay = day;
    _selectedDaySlot = slot.copy();
    _selectedDaySlot.taken = true;
    _selectedHour = dateTime;

    final needPatient = _patient == null;
    _showPatientInfo = needPatient;
    if (needPatient) {
      notifyListeners();
    } else {
      _onConfirm();
    }
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

  set setOnConfirm(Function onConfirm) {
    _onConfirm = onConfirm;
  }

  set setPatient(Patient patient) {
    _patient = patient;

    _showPatientInfo = false;
    _onConfirm();
  }

  set setDoctor(Doctor doctor) {
    _doctor = doctor;
  }

  set setSelectedCenter(CenterInfo centerInfo) {
    _selectedCenter = centerInfo;
    loadCalendar(centerInfo.idReference, centerInfo.calendarReference);
    notifyListeners();
  }

  set _setCalendarStatus(CalendarStatus getCalendarStatus) {
    _calendarStatus = getCalendarStatus;
    notifyListeners();
  }

  bool get showPatientInfo {
    return _showPatientInfo;
  }

  Patient get getPatient {
    return _patient;
  }

  Day get getSelectedDate {
    return _selectedDay;
  }

  Doctor get getDoctor {
    return _doctor;
  }

  CenterInfo get getSelectedCenter {
    return _selectedCenter;
  }

  CalendarStatus get getCalendarStatus {
    return _calendarStatus;
  }

  DaySlot get getSelectedHour {
    return _selectedDaySlot;
  }

  DateTime get getSelectedDateTime {
    return _selectedHour;
  }
}

class CalendarStatus {
  final bool error;
  final bool loading;
  final Calendar data;

  CalendarStatus(this.error, this.loading, this.data);
}
