import 'package:project_docere/domain/models/doctor.dart';

abstract class IDoctorDataSource {
  Future<List<Doctor>> list();
}

abstract class IDoctorRemoteDataSource extends IDoctorDataSource {}

abstract class IDoctorLocalDataSource extends IDoctorDataSource {}
