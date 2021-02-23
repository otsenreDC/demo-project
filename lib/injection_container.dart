import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:project_docere/data/local/data_sources/db_data_source.dart';
import 'package:project_docere/data/remote/data_sources/doctor/firestore_data_source.dart';
import 'package:project_docere/domain/data_sources/doctors_data_source.dart';
import 'package:project_docere/domain/repositories/patient/patient_repository.dart';
import 'package:project_docere/framework/helpers/network_info_helper.dart';
import 'package:project_docere/framework/ui/doctors/doctor_list_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/helpers/netork_info_helper.dart';
import 'domain/use_cases/doctors/get_list_doctors_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Data sources
  sl.registerLazySingleton<IDoctorLocalDataSource>(
    () => DoctorDatabaseDataSource(),
  );
  sl.registerLazySingleton<IDoctorRemoteDataSource>(
    () => DoctorFirestoreDataSource(sl()),
  );

  // Repositories
  sl.registerLazySingleton<IPatientRepository>(
    () => PatientRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
      connectionChecker: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(
    () => GetListDoctorsUseCase(sl()),
  );

  // View models
  sl.registerFactory(
    () => DoctorListViewModel(getPatientDoctorsUseCase: sl()),
  );

  // Core

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  // http
  sl.registerLazySingleton<INetworkInfoHelper>(() => NetworkInfoHelper());
  // Firestore
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
}
