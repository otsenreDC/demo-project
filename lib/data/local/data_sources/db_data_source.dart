import 'dart:async';

import 'package:project_docere/data/local/dtos/doctor_data.dart';
import 'package:project_docere/domain/data_sources/doctors_data_source.dart';
import 'package:project_docere/domain/models/doctor.dart';

class DoctorDatabaseDataSource extends IDoctorLocalDataSource {
  @override
  Future<List<Doctor>> list() {
    final completer = Completer<List<Doctor>>();

    final doctors = [DoctorData(name: "Juan")]
        .map(
          (e) => e.toDomain(),
        )
        .toList();

    completer.complete(doctors);

    return completer.future;
  }
}
