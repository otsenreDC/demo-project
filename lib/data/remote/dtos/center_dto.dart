import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:project_docere/data/remote/dtos/calendar_dto.dart';
import 'package:project_docere/data/remote/dtos/secretary_dto.dart';
import 'package:project_docere/domain/models/center_info.dart';

final String _keyIdReference = "idReference";
final String _keyName = "name";
final String _keyAddress = "address";
final String _keyCalendar = "calendar";
final String _ketSecretaryIds = "secretarias";
final String _keyCalendarReference = "calendarReference";

class CenterInfoDTO {
  String idReference;

  String calendarReference;
  String name;
  String address;

  List<SecretaryDTO> secretaries;
  CalendarDTO calendar;

  CenterInfoDTO({
    @required this.idReference,
    @required this.calendarReference,
    @required this.name,
    @required this.address,
    @required this.secretaries,
    @required this.calendar,
  });

  CenterInfo toDomain() {
    return CenterInfo(
      idReference: this.idReference,
      name: this.name,
      address: this.address,
      secretaries: this.secretaries.map((e) => e.toDomain()).toList(),
      calendar: this.calendar == null ? null : this.calendar.toDomain(),
      calendarReference: this.calendarReference,
    );
  }

  factory CenterInfoDTO.fromJson(Map<String, dynamic> json) {
    Iterable secretaries = json[_ketSecretaryIds];
    DocumentReference calendarReference = json[_keyCalendarReference];
    DocumentReference centerIdReference = json[_keyIdReference];

    return CenterInfoDTO(
        idReference: centerIdReference?.path,
        name: json[_keyName],
        address: json[_keyAddress],
        secretaries: secretaries
            .map((secretary) =>
                SecretaryDTO.fromJson(secretary as Map<String, dynamic>))
            .toList(),
        calendar: CalendarDTO.fromJson(json[_keyCalendar]),
        calendarReference: calendarReference?.path);
  }
}
