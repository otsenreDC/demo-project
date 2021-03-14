import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/data_sources/appointments_data_source.dart';
import 'package:project_docere/domain/models/failure.dart';

const String _collectionAppointments = "citas";

class AppointmentFirestoreDataStore implements IAppointmentRemoteDataSource {
  FirebaseFirestore _firestore;

  AppointmentFirestoreDataStore(FirebaseFirestore firestore) {
    _firestore = firestore;
  }

  @override
  Future<Either<Failure, String>> create(
    String centerProfileReference,
    String doctorProfileReference,
    String secretaryProfileReference,
    String patientProfileReference,
    String attentionOrder,
    DateTime appointmentAt,
    String comments,
  ) {
    final completer = Completer<Either<Failure, String>>();
    try {
      _firestore.collection(_collectionAppointments).add(
        {
          "centerReference": _firestore.doc(centerProfileReference),
          "doctorReference": _firestore.doc(doctorProfileReference),
          "patientReference": _firestore.doc(patientProfileReference),
          "secretaryReference": _firestore.doc(secretaryProfileReference),
          "attentionOrder": attentionOrder,
          "comments": comments,
          "appointmentAt": Timestamp.fromDate(appointmentAt),
          "createdAt": Timestamp.fromDate(DateTime.now()),
        },
      ).then(
        (value) => completer.complete(
          Right(
            value.id,
          ),
        ),
      );
    } catch (e) {
      completer.complete(
        Left(
          Failure(),
        ),
      );
    }
    return completer.future;
  }
}
