import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_docere/domain/models/insurance.dart';
import 'package:project_docere/domain/models/patient.dart';
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
  Patient patient;
  Secretary secretary;
  AppointmentStatus status = AppointmentStatus.scheduled;
  Insurance insurance;

  Appointment({
    this.appointmentReference,
    this.appointmentAt,
    this.doctor,
    this.secretary,
    this.centerInfo,
    this.patient,
    this.createdAt,
    this.comments,
    this.attentionOrder,
    this.status,
  });

  static String attentionOrderHour = "hour";
  static String attentionOrderArrival = "order";

  bool get isCheckedIn => status == AppointmentStatus.checkedIn;

  bool get isScheduled => status == AppointmentStatus.scheduled;

  bool get isCancelled => status == AppointmentStatus.cancelled;

  bool get isAttentionOnOrderOfArrival =>
      attentionOrder == attentionOrderArrival;

  bool get isAttentionByHour => attentionOrder == attentionOrderHour;

  bool get hasInsurance => insurance?.authorizationNumber != null;
}

enum AppointmentStatus {
  cancelled,
  checkedIn,
  scheduled,
  confirmed,
  inMedicalConsultation,
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
    if (this.index == AppointmentStatus.inMedicalConsultation.index) {
      return "IN_MEDICAL_CONSULTATION";
    }
    return "UNDETERMINED";
  }

  String readable() {
    if (this.index == AppointmentStatus.cancelled.index) {
      return "Cancleada";
    }
    if (this.index == AppointmentStatus.checkedIn.index) {
      return "Registrado";
    }
    if (this.index == AppointmentStatus.scheduled.index) {
      return "Agendado";
    }
    if (this.index == AppointmentStatus.confirmed.index) {
      return "Confirmado";
    }
    if (this.index == AppointmentStatus.inMedicalConsultation.index) {
      return "En consulta";
    }
    return "Indeterminado";
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
  if (status == "IN_MEDICAL_CONSULTATION") {
    return AppointmentStatus.inMedicalConsultation;
  }
  return AppointmentStatus.undetermined;
}
