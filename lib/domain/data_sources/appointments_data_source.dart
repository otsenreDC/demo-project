import 'package:either_option/either_option.dart';
import 'package:project_docere/data/remote/dtos/appointment_dto.dart';
import 'package:project_docere/domain/models/failure.dart';

abstract class IAppointmentDataSource {
  Future<Either<Failure, List<AppointmentDTO>>> list();

  Future<Either<Failure, String>> create(
    AppointmentDTO appointmentDTO,
  );

  Future<Either<Failure, bool>> updateStatus(
      String appointmentReference, String newStatus
      );
}

abstract class IAppointmentRemoteDataSource extends IAppointmentDataSource {}
