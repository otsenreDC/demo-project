import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/data/remote/dtos/center_dto.dart';
import 'package:project_docere/data/remote/dtos/doctor_dto.dart';
import 'package:project_docere/data/remote/dtos/secretary_dto.dart';
import 'package:project_docere/domain/models/appointment.dart';

final String _keyAppointmentAt = "appointmentAt";
final String _keyAttentionOrder = "attentionOrder";
final String _keyComments = "comments";
final String _keyCreatedAt = "createdAt";
final String _keyCenterReference = "centerInfo";
final String _keyDoctor = "doctor";
final String _keyDoctorReference = "doctorReference";
final String _keyPatientReference = "patient";
final String _keySecretaryReference = "secretary";
final String _keyStatus = "status";

class AppointmentDTO {
  String appointmentReference;
  String attentionOrder;
  String comments;
  Timestamp appointmentAt;
  Timestamp createdAt;
  CenterInfoDTO centerInfo;
  DoctorDTO doctor;
  String patientReference;
  SecretaryDTO secretary;
  String status;

  AppointmentDTO(
      {@required this.attentionOrder,
      @required this.comments,
      @required this.appointmentAt,
      @required this.createdAt,
      @required this.centerInfo,
      @required this.doctor,
      @required this.patientReference,
      @required this.secretary,
      @required this.status});

  factory AppointmentDTO.fromJson(Map<String, dynamic> json) {
    return AppointmentDTO(
        attentionOrder: json[_keyAttentionOrder],
        comments: json[_keyComments],
        appointmentAt: json[_keyAppointmentAt],
        createdAt: json[_keyCreatedAt],
        patientReference:
            (json[_keyPatientReference] as DocumentReference)?.path,
        centerInfo: CenterInfoDTO.fromJson(json[_keyCenterReference]),
        doctor: DoctorDTO.fromJson(null, json[_keyDoctor]),
        secretary: SecretaryDTO.fromJson(json[_keySecretaryReference]),
        status: json[_keyStatus]);
  }

  Map<String, dynamic> toJson(FirebaseFirestore firestore) {
    final patientReference =
        (this.patientReference != null && this.patientReference.isNotEmpty
            ? firestore.doc(this.patientReference)
            : null);

    return Map.fromEntries([
      MapEntry(_keyAttentionOrder, attentionOrder),
      MapEntry(_keyComments, comments),
      MapEntry(_keyAppointmentAt, appointmentAt),
      MapEntry(_keyCreatedAt, createdAt),
      MapEntry(_keyPatientReference, patientReference),
      MapEntry(_keyCenterReference, centerInfo.toJson(firestore)),
      MapEntry(_keySecretaryReference, secretary.toJson()),
      MapEntry(_keyDoctor, doctor.toJson(firestore)),
      MapEntry(_keyDoctorReference, doctor.idReference),
      MapEntry(_keyStatus, status)
    ]);
  }

  Appointment toDomain() => Appointment(
      appointmentReference: appointmentReference,
      patientReference: patientReference,
      secretary: secretary.toDomain(),
      doctor: doctor.toDomain(),
      centerInfo: centerInfo.toDomain(),
      attentionOrder: attentionOrder,
      comments: comments,
      createdAt: createdAt,
      appointmentAt: appointmentAt,
      status: appointmentStatusFromString(status));
}
