import 'package:either_option/either_option.dart';
import 'package:flutter/foundation.dart';
import 'package:project_docere/domain/data_sources/doctors_data_source.dart';
import 'package:project_docere/domain/helpers/netork_info_helper.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/failure.dart';

abstract class IPatientRepository {
  Future<Either<Failure, List<Doctor>>> getDoctors();
}

class PatientRepository extends IPatientRepository {
  final IDoctorLocalDataSource localDataSource;
  final IDoctorRemoteDataSource remoteDataSource;
  final INetworkInfoHelper connectionChecker;

  PatientRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.connectionChecker,
  });

  @override
  Future<Either<Failure, List<Doctor>>> getDoctors() async {
    if (await connectionChecker.isConnected()) {
      try {
        final List<Doctor> doctors = await remoteDataSource.list();
        // cache data
        return Right(doctors);
      } on Exception {
        return Left(Failure());
      }
    } else {
      try {
        final List<Doctor> doctors = await localDataSource.list();
        return Right(doctors);
      } on Exception {
        return Left(Failure());
      }
    }
  }
}
