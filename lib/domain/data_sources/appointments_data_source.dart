import 'package:either_option/either_option.dart';
import 'package:project_docere/domain/models/failure.dart';

abstract class IAppointmentDataSource {
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

abstract class IAppointmentRemoteDataSource extends IAppointmentDataSource {}
