import 'package:either_option/either_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_docere/domain/models/center_info.dart';
import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/models/ui_state.dart';
import 'package:project_docere/domain/use_cases/appointments/create_appointment_uc.dart';

class ConfirmAppointmentViewModel extends ChangeNotifier {
  CreateAppointmentUseCase _createAppointmentUseCase;

  Doctor _doctor;
  CenterInfo _centerInfo;
  Day _day;
  DaySlot _daySlot;
  DateTime _dateTime;

  ConfirmAppointmentViewModel(
      CreateAppointmentUseCase createAppointmentUseCase) {
    this._createAppointmentUseCase = createAppointmentUseCase;
  }

  UIState _state = UILoading();

  UIState get getUIState {
    return _state;
  }

  set setUIState(UIState state) {
    _state = state;
    notifyListeners();
  }

  DateTime get appointmentDate {
    return _dateTime;
  }

  DaySlot get appointmentSlot {
    return _daySlot;
  }

  Doctor get doctor {
    return _doctor;
  }

  String get centerName {
    return _centerInfo.name;
  }

  String get centerAddress {
    return _centerInfo.address;
  }

  String get secretaryName {
    return _centerInfo.secretaries.first?.name;
  }

  String get secretaryPhoneNumber {
    return _centerInfo.secretaries.first?.phone;
  }

  DateTime getStartHour() {
    return appointmentSlot.start?.toDate();
  }

  void init(
    Doctor doctor,
    CenterInfo centerInfo,
    Day day,
    DaySlot daySlot,
    DateTime dateTime,
  ) {
    _doctor = doctor;
    _centerInfo = centerInfo;
    _day = day;
    _daySlot = daySlot;
    _dateTime = dateTime;

    setUIState = UIShowData();
  }

  void createAppointment() {
    setUIState = UILoading();
    _createAppointmentUseCase
        .execute(
            _centerInfo.idReference,
            _doctor.idReference,
            _centerInfo.calendarReference,
            _centerInfo.secretaries.first?.profileReference,
            "pacientes/1234",
            _daySlot.inOrderOfArrival,
            _day,
            _daySlot,
            _dateTime)
        .then(
          (Either<Failure, bool> value) => {
            value.fold(
              (failure) {
                setUIState = UIError(message: "Error creaando cita");
              },
              (done) {
                setUIState = UIShowData<bool>(data: true);
              },
            )
          },
          // )
          // .catchError(
          //   (error) => {
          //     setUIState = UIError(message: "ERROR"),
          //   },
        );
  }
}
