import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/data/remote/dtos/center_dto.dart';
import 'package:project_docere/data/remote/dtos/doctor_dto.dart';
import 'package:project_docere/data/remote/dtos/insurance_dto.dart';
import 'package:project_docere/data/remote/dtos/patient_dto.dart';
import 'package:project_docere/data/remote/dtos/secretary_dto.dart';
import 'package:project_docere/domain/models/appointment.dart';

final String _keyAppointmentAt = "appointmentAt";
final String _keyAttentionOrder = "attentionOrder";
final String _keyComments = "comments";
final String _keyCreatedAt = "createdAt";
final String _keyCenterReference = "centerInfo";
final String _keyDoctor = "doctor";
final String _keyDoctorReference = "doctorReference";
final String _keyPatient = "patient";
final String _keySecretaryReference = "secretary";
final String _keyStatus = "status";
final String _keyInsurance = "insurance";

class AppointmentDTO {
  String appointmentReference;
  String attentionOrder;
  String comments;
  Timestamp appointmentAt;
  Timestamp createdAt;
  CenterInfoDTO centerInfo;
  DoctorDTO doctor;
  PatientDTO patient;
  SecretaryDTO secretary;
  String status;
  InsuranceDTO insurance;

  AppointmentDTO({
    @required this.attentionOrder,
    @required this.comments,
    @required this.appointmentAt,
    @required this.createdAt,
    @required this.centerInfo,
    @required this.doctor,
    @required this.patient,
    @required this.secretary,
    @required this.status,
    @required this.insurance,
  });

  factory AppointmentDTO.fromJson(Map<String, dynamic> json) {
    return AppointmentDTO(
      attentionOrder: json[_keyAttentionOrder],
      comments: json[_keyComments],
      appointmentAt: json[_keyAppointmentAt],
      createdAt: json[_keyCreatedAt],
      patient: PatientDTO.fromJson(json[_keyPatient]),
      centerInfo: CenterInfoDTO.fromJson(json[_keyCenterReference]),
      doctor: DoctorDTO.fromJson(null, json[_keyDoctor]),
      secretary: SecretaryDTO.fromJson(json[_keySecretaryReference]),
      status: json[_keyStatus],
      insurance: InsuranceDTO.fromJson(json[_keyInsurance]),
    );
  }

  Map<String, dynamic> toJson(FirebaseFirestore firestore) {
    return Map.fromEntries([
      MapEntry(_keyAttentionOrder, attentionOrder),
      MapEntry(_keyComments, comments),
      MapEntry(_keyAppointmentAt, appointmentAt),
      MapEntry(_keyCreatedAt, createdAt),
      MapEntry(_keyPatient, patient.toJson(firestore)),
      MapEntry(_keyCenterReference, centerInfo.toJson(firestore)),
      MapEntry(_keySecretaryReference, secretary.toJson()),
      MapEntry(_keyDoctor, doctor.toJson(firestore)),
      MapEntry(_keyDoctorReference, firestore.doc(doctor.idReference)),
      MapEntry(_keyStatus, status),
      MapEntry(_keyInsurance, insurance?.toJson())
    ]);
  }

  Appointment toDomain() => Appointment(
      appointmentReference: appointmentReference,
      patient: patient.toDomain(),
      secretary: secretary.toDomain(),
      doctor: doctor.toDomain(),
      centerInfo: centerInfo.toDomain(),
      attentionOrder: attentionOrder,
      comments: comments,
      createdAt: createdAt,
      appointmentAt: appointmentAt,
      status: appointmentStatusFromString(status),
      insurance: insurance?.toDomain());
}
