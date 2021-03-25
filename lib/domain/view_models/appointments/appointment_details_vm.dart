import 'package:flutter/material.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/insurance.dart';
import 'package:project_docere/domain/use_cases/appointments/change_appointment_status_uc.dart';
import 'package:project_docere/domain/use_cases/appointments/update_appointment_insurance_uc.dart';

class AppointmentDetailsViewModel extends ChangeNotifier {
  ChangeAppointmentStatusUseCase _changeAppointmentStatusUseCase;
  UpdateAppointmentInsuranceUseCase _updateAppointmentInsuranceUseCase;
  Appointment _appointment;
  Insurance _newInsurance;

  AppointmentDetailsViewModel(this._changeAppointmentStatusUseCase,
      this._updateAppointmentInsuranceUseCase);

  void init(Appointment appointment) {
    this._appointment = appointment;
  }

  Appointment get getAppointment {
    return _appointment;
  }

  String get doctorName {
    return _appointment?.doctor?.fullName;
  }

  String get doctorSpecialty {
    return _appointment?.doctor?.specialty;
  }

  Doctor get doctor {
    return _appointment?.doctor;
  }

  DateTime get timeToStart {
    return _appointment?.appointmentAt?.toDate();
  }

  String get centerName {
    return _appointment?.centerInfo?.name;
  }

  String get centerAddress {
    return _appointment?.centerInfo?.address;
  }

  String get secretaryName {
    return _appointment?.secretary?.name;
  }

  String get secretaryPhone {
    return _appointment?.secretary?.phone;
  }

  set setInsurance(Insurance insurance) {
    _newInsurance = insurance;
    updateInsurance(insurance);
    notifyListeners();
  }

  Insurance get getInsurance {
    return _appointment?.insurance;
  }

  bool get hasInsurance {
    return _newInsurance != null || _appointment?.insurance != null;
  }

  PatientDetails get patientDetails {
    return PatientDetails(
      _appointment?.patient?.fullName,
      "(888) 555-1234",
      "000-1234567-8",
      "01/01/1970",
      "Santiago",
    );
  }

  String get appointmentStatus {
    return _appointment?.status?.readable();
  }

  bool get isAttentionOrderInOrderOfArrival {
    return _appointment?.isAttentionOnOrderOfArrival == true;
  }

  bool get canBeCheckedIn {
    return _appointment?.isScheduled == true;
  }

  bool get canBeCancelled {
    return _appointment?.isScheduled == true ||
        _appointment?.isCheckedIn == true;
  }

  bool get canBeEdited {
    return _appointment?.isScheduled == true;
  }

  bool get canLetThePatientPass {
    return _appointment?.isCheckedIn == true;
  }

  bool get canAddInsurance {
    return (_appointment?.isScheduled == true ||
            _appointment?.isCheckedIn == true) &&
        _appointment?.hasInsurance == false &&
        _newInsurance == null;
  }

  void checkIn() async {
    final result = await _changeAppointmentStatusUseCase.execute(
        _appointment.appointmentReference, AppointmentStatus.checkedIn);

    result.fold((failure) => _handleError(),
        (success) => success ? _setChecked() : _handleError());
  }

  void letThePatientSeeTheDoctor() async {
    final result = await _changeAppointmentStatusUseCase.execute(
        _appointment.appointmentReference,
        AppointmentStatus.inMedicalConsultation);

    result.fold(
      (failure) => _handleError(),
      (success) => success ? _setInMedicalConsultation() : _handleError(),
    );
  }

  void cancel() async {
    final result = await _changeAppointmentStatusUseCase.execute(
      _appointment.appointmentReference,
      AppointmentStatus.cancelled,
    );

    result.fold((failure) => _handleError(),
        (success) => success ? _setCanceled() : _handleError());
  }

  void updateInsurance(Insurance insurance) async {
    final result = await _updateAppointmentInsuranceUseCase.execute(
      _appointment.appointmentReference,
      _newInsurance,
    );

    result.fold(
      (failure) => _handleError(),
      (done) {
        _appointment.insurance = _newInsurance;
        notifyListeners();
      },
    );
  }

  void _setChecked() {
    _appointment.status = AppointmentStatus.checkedIn;
    notifyListeners();
  }

  void _setInMedicalConsultation() {
    _appointment.status = AppointmentStatus.inMedicalConsultation;
    notifyListeners();
  }

  void _setCanceled() {
    _appointment.status = AppointmentStatus.cancelled;
    notifyListeners();
  }

  void _handleError() {}
}

class PatientDetails {
  final String name;
  final String phone;
  final String personalId;
  final String birthday;
  final String city;

  PatientDetails(
    this.name,
    this.phone,
    this.personalId,
    this.birthday,
    this.city,
  );
}