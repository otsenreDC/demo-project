import 'package:get_it/get_it.dart';
import 'package:project_docere/domain/repositories/patient/patient_repository.dart';
import 'package:project_docere/domain/use_cases/doctors/get_patient_doctors_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repositories/patient_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Use cases
  sl.registerLazySingleton(() => GetPatientDoctorsUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<IPatientRepository>(() => PatientRepository());

  // Data sources

  // Core

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  // http
  // data connection checker
}
