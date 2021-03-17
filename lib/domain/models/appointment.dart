import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_docere/domain/models/secretary.dart';

import 'center_info.dart';
import 'doctor.dart';

class Appointment {
  String appointmentReference;
  String attentionOrder;
  String comments;
  Timestamp appointmentAt;
  Timestamp createdAt;
  CenterInfo centerInfo;
  Doctor doctor;
  String patientReference;
  Secretary secretary;
  AppointmentStatus status = AppointmentStatus.scheduled;

  Appointment({
    this.appointmentReference,
    this.appointmentAt,
    this.doctor,
    this.secretary,
    this.centerInfo,
    this.patientReference,
    this.createdAt,
    this.comments,
    this.attentionOrder,
    this.status,
  });

  bool get isCheckedIn => status == AppointmentStatus.checkedIn;
  bool get isScheduled => status == AppointmentStatus.scheduled;
  bool get isCancelled => status == AppointmentStatus.cancelled;
}

enum AppointmentStatus {
  cancelled,
  checkedIn,
  scheduled,
  confirmed,
  undetermined
}

extension AppointmentStatusString on AppointmentStatus {
  String string() {
    if (this.index == AppointmentStatus.cancelled.index) {
      return "CANCELLED";
    }
    if (this.index == AppointmentStatus.checkedIn.index) {
      return "CHECKED_IN";
    }
    if (this.index == AppointmentStatus.scheduled.index) {
      return "SCHEDULED";
    }
    if (this.index == AppointmentStatus.confirmed.index) {
      return "CONFIRMED";
    }
    return "UNDETERMINED";
  }
}

AppointmentStatus appointmentStatusFromString(String status) {
  if (status == "CANCELLED") {
    return AppointmentStatus.cancelled;
  }
  if (status == "CHECKED_IN") {
    return AppointmentStatus.checkedIn;
  }
  if (status == "SCHEDULED") {
    return AppointmentStatus.scheduled;
  }
  if (status == "CONFIRMED") {
    return AppointmentStatus.confirmed;
  }
  return AppointmentStatus.undetermined;
}
