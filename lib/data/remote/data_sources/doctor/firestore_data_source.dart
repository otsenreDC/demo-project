import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_option/either_option.dart';
import 'package:project_docere/data/remote/dtos/calendar_dto.dart';
import 'package:project_docere/data/remote/dtos/doctor_dto.dart';
import 'package:project_docere/domain/data_sources/doctors_data_source.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/failure.dart';

final String _collectionDoctors = "doctores";

class DoctorFirestoreDataSource extends IDoctorRemoteDataSource {
  FirebaseFirestore _firestore;

  DoctorFirestoreDataSource(FirebaseFirestore firestore) {
    _firestore = firestore;
  }

  @override
  Future<List<Doctor>> list() async {
    QuerySnapshot snapshot =
        await _firestore.collection(_collectionDoctors).get();

    Iterator<DocumentSnapshot> docs = snapshot.docs.iterator;

    final List<Doctor> doctors = List.empty(growable: true);

    while (docs.moveNext()) {
      final currentId = docs.current.id;
      final Map<String, dynamic> doctor = docs.current.data();
      doctors.add(
        DoctorDTO.fromJson(currentId, doctor).toDomain(),
      );
    }

    return doctors;
  }

  @override
  Future<CalendarDTO> getCalendar(
    String doctorId,
    String centerId,
    String calendarReference,
    int year,
  ) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .doc(doctorId)
          .collection("calendars/$calendarReference/$year")
          .get();

      Iterator<DocumentSnapshot> docs = snapshot.docs.iterator;

      final List<DayDTO> days = List.empty(growable: true);

      while (docs.moveNext()) {
        final Map<String, dynamic> day = docs.current.data();
        final DayDTO dto = DayDTO.fromJson(day);
        dto.id = docs.current.id;
        days.add(dto);
      }

      return CalendarDTO.days(days);
    } catch (e) {
      print(e);
      return CalendarDTO();
    }
  }

  @override
  Future<Either<Failure, bool>> updateDaySlot(
    String doctorIdReference,
    String calendarIdReference,
    DayDTO day,
    DaySlotDTO daySlot,
  ) async {
    final slots = day.daySlots;
    final slotToUpdate =
        slots.firstWhere((child) => child.start == daySlot.start);

    slotToUpdate.appointmentReference = daySlot.appointmentReference;
    slotToUpdate.taken = daySlot.taken;
    slotToUpdate.start = daySlot.start;

    try {
      await _firestore
          .doc(doctorIdReference)
          .collection("$calendarIdReference/${2021}")
          .doc(day.id)
          .update(day.toJson(_firestore));

      return Right(true);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<Doctor>>> getSecretaryDoctors(
    String secretaryReference,
  ) async {
    try {
      final doctorReference = _firestore.collection(_collectionDoctors);
      final query = doctorReference.where("secretaryReferences",
          arrayContains: secretaryReference);

      final snapshot = await query.get();

      Iterator<DocumentSnapshot> docs = snapshot.docs.iterator;

      final List<Doctor> doctors = List.empty(growable: true);

      while (docs.moveNext()) {
        final currentId = docs.current.id;
        final Map<String, dynamic> doctor = docs.current.data();
        doctors.add(
          DoctorDTO.fromJson(currentId, doctor).toDomain(),
        );
      }

      return Right(doctors);
    } catch (e) {
      return Left(Failure());
    }
  }
}
