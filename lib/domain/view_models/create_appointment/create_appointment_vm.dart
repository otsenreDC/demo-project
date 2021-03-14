import 'package:flutter/cupertino.dart';
import 'package:project_docere/domain/models/calendar.dart';
import 'package:project_docere/domain/models/center_info.dart';
import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/use_cases/doctors/get_current_calendar_uc.dart';

class CreateAppointmentViewModel extends ChangeNotifier {
  GetCurrentCalendarUseCase _getCurrentCalendarUseCase;

  CreateAppointmentViewModel(
    GetCurrentCalendarUseCase getCurrentCalendarUseCase,
  ) {
    _getCurrentCalendarUseCase = getCurrentCalendarUseCase;
  }

  Doctor _doctor;
  CenterInfo _selectedCenter;

  Day _selectedDate;
  DaySlot _selectedHour;
  DateTime _selectedDateTime;

  CalendarStatus _calendarStatus = CalendarStatus(false, false, null);

  void start(Doctor doctor) {
    this._doctor = doctor;
    notifyListeners();
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
        .then((value) => {
              if (value is Calendar)
                {
                  _setCalendarStatus = CalendarStatus(false, false, value),
                }
              else
                {
                  _setCalendarStatus = CalendarStatus(false, true, null),
                }
            });
  }

/*
  CalendarDay get getCalendarDay {
    if (_selectedCenter == null || _selectedCenter.calendar == null)
      return null;
    switch (_selectedDate.weekday) {
      case DateTime.monday:
        return _selectedCenter.calendar.monday;
      case DateTime.tuesday:
        return _selectedCenter.calendar.tuesday;
      case DateTime.wednesday:
        return _selectedCenter.calendar.wednesday;
      case DateTime.thursday:
        return _selectedCenter.calendar.thursday;
      case DateTime.friday:
        return _selectedCenter.calendar.friday;
      case DateTime.saturday:
        return _selectedCenter.calendar.saturday;
      default:
        return _selectedCenter.calendar.sunday;
    }
  }
   */

}

class CalendarStatus {
  final bool error;
  final bool loading;
  final Calendar data;

  CalendarStatus(this.error, this.loading, this.data);
}
