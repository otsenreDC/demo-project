import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_docere/data/remote/dtos/doctor_dto.dart';
import 'package:project_docere/domain/data_sources/doctors_data_source.dart';
import 'package:project_docere/domain/models/doctor.dart';

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
      final Map<String, dynamic> doctor = docs.current.data();
      doctors.add(
        DoctorDTO.fromJson(doctor).toDomain(),
      );
    }

    return doctors;
  }
}
