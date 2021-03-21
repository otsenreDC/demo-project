import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_option/either_option.dart';
import 'package:project_docere/data/remote/dtos/appointment_dto.dart';
import 'package:project_docere/domain/data_sources/appointments_data_source.dart';
import 'package:project_docere/domain/models/failure.dart';

const String _collectionAppointments = "citas";

class AppointmentFirestoreDataStore implements IAppointmentRemoteDataSource {
  FirebaseFirestore _firestore;

  AppointmentFirestoreDataStore(FirebaseFirestore firestore) {
    _firestore = firestore;
  }

  @override
  Future<Either<Failure, String>> create(AppointmentDTO appointment) {
    final completer = Completer<Either<Failure, String>>();
    try {
      _firestore
          .collection(_collectionAppointments)
          .add(
            appointment.toJson(_firestore),
          )
          .then(
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

  @override
  Future<Either<Failure, List<AppointmentDTO>>> list() async {
    try {
      final QuerySnapshot result =
          await _firestore.collection(_collectionAppointments).get();

      final appointments = result.docs.map(
        (json) {
          final appointment = AppointmentDTO.fromJson(
            json.data(),
          );

          appointment.appointmentReference = "citas/${json.id}";
          return appointment;
        },
      ).toList();

      return Right(appointments);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<AppointmentDTO>>> listByDoctor(
    String doctorReference,
  ) async {
    try {
      final reference = _firestore.collection(_collectionAppointments);
      final query = reference.where(
        "doctorReference",
        isEqualTo: _firestore.doc(doctorReference),
      );
      final QuerySnapshot result = await query.get();

      final appointments = result.docs.map(
        (json) {
          final appointment = AppointmentDTO.fromJson(
            json.data(),
          );

          appointment.appointmentReference = "citas/${json.id}";
          return appointment;
        },
      ).toList();

      return Right(appointments);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateStatus(
    String appointmentReference,
    String newStatus,
  ) async {
    try {
      await _firestore.doc(appointmentReference).update(
            Map.fromEntries(
              [
                MapEntry("status", newStatus),
              ],
            ),
          );
      return Right(true);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateTime(
    String appointmentReference,
    Timestamp appointmentAt,
    String attentionOrder,
  ) async {
    try {
      await _firestore.doc(appointmentReference).update(
            Map.fromEntries(
              [
                MapEntry("attentionOrder", attentionOrder),
                MapEntry("appointmentAt", appointmentAt),
              ],
            ),
          );
      return Right(true);
    } catch (e) {
      return Left(Failure());
    }
  }
}
