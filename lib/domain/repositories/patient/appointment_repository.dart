import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_option/either_option.dart';
import 'package:project_docere/data/remote/dtos/appointment_dto.dart';
import 'package:project_docere/data/remote/dtos/center_dto.dart';
import 'package:project_docere/data/remote/dtos/doctor_dto.dart';
import 'package:project_docere/data/remote/dtos/secretary_dto.dart';
import 'package:project_docere/domain/data_sources/appointments_data_source.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/models/center_info.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/failure.dart';
import 'package:project_docere/domain/models/secretary.dart';

abstract class IAppointmentRepository {
  Future<Either<Failure, String>> create(
    CenterInfo centerInfo,
    Doctor doctor,
    Secretary secretary,
    String patientReference,
    String attentionOrder,
    DateTime appointmentAt,
    String comments,
  );

  Future<Either<Failure, List<Appointment>>> list();

  Future<Either<Failure, bool>> updateStatus(
    String appointmentReference,
    AppointmentStatus newStatus,
  );
}

class AppointmentRepository implements IAppointmentRepository {
  IAppointmentRemoteDataSource dataStore;

  AppointmentRepository({this.dataStore});

  @override
  Future<Either<Failure, String>> create(
    CenterInfo centerInfo,
    Doctor doctor,
    Secretary secretary,
    String patientReference,
    String attentionOrder,
    DateTime appointmentAt,
    String comments,
  ) {
    final appointment = AppointmentDTO(
      appointmentAt: Timestamp.fromDate(appointmentAt),
      createdAt: Timestamp.now(),
      comments: "",
      attentionOrder: attentionOrder,
      centerInfo: CenterInfoDTO.fromDomain(centerInfo),
      doctor: DoctorDTO.fromDomain(doctor),
      secretary: SecretaryDTO.fromDomain(secretary),
      patientReference: patientReference,
      status: AppointmentStatus.scheduled.string(),
    );
    return dataStore.create(appointment);
  }

  @override
  Future<Either<Failure, List<Appointment>>> list() async {
    try {
      final result = await dataStore.list();

      final Either<Failure, List<Appointment>> value = result.fold((failure) {
        return Left(Failure());
      }, (dtos) {
        return Right(
          dtos.map((dto) => dto.toDomain()).toList(),
        );
      });

      return value;
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateStatus(
    String appointmentReference,
    AppointmentStatus newStatus,
  ) async {
    try {
      final result = await dataStore.updateStatus(
        appointmentReference,
        newStatus.string(),
      );

      return result;
    } catch (e) {
      return Left(Failure());
    }
  }
}
