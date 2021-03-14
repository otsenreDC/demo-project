import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/data_sources/appointments_data_source.dart';
import 'package:project_docere/domain/models/failure.dart';

abstract class IAppointmentRepository {
  Future<Either<Failure, String>> create(
    String centerProfileReference,
    String doctorProfileReference,
    String secretaryProfileReference,
    String patientProfileReference,
    String attentionOrder,
    DateTime appointmentAt,
    String comments,
  );
}

class AppointmentRepository implements IAppointmentRepository {
  IAppointmentRemoteDataSource dataStore;

  AppointmentRepository({this.dataStore});

  @override
  Future<Either<Failure, String>> create(
    String centerProfileReference,
    String doctorProfileReference,
    String secretaryProfileReference,
    String patientProfileReference,
    String attentionOrder,
    DateTime appointmentAt,
    String comments,
  ) =>
      dataStore.create(
          centerProfileReference,
          doctorProfileReference,
          secretaryProfileReference,
          patientProfileReference,
          attentionOrder,
          appointmentAt,
          comments);
}
