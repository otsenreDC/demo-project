import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:project_docere/data/local/data_sources/db_data_source.dart';
import 'package:project_docere/data/remote/data_sources/doctor/appointment_firestore_ds.dart';
import 'package:project_docere/data/remote/data_sources/doctor/firestore_data_source.dart';
import 'package:project_docere/domain/data_sources/appointments_data_source.dart';
import 'package:project_docere/domain/data_sources/doctors_data_source.dart';
import 'package:project_docere/domain/models/session.dart';
import 'package:project_docere/domain/repositories/patient/appointment_repository.dart';
import 'package:project_docere/domain/repositories/patient/doctor_repository.dart';
import 'package:project_docere/domain/repositories/patient/patient_repository.dart';
import 'package:project_docere/domain/use_cases/appointments/change_appointment_status_uc.dart';
import 'package:project_docere/domain/use_cases/appointments/change_appointment_time.dart';
import 'package:project_docere/domain/use_cases/appointments/create_appointment_uc.dart';
import 'package:project_docere/domain/use_cases/appointments/get_appointments_uc.dart';
import 'package:project_docere/domain/use_cases/doctors/get_current_calendar_uc.dart';
import 'package:project_docere/domain/use_cases/doctors/get_doctor_appointments_uc.dart';
import 'package:project_docere/domain/use_cases/doctors/get_secretary_doctors_uc.dart';
import 'package:project_docere/domain/view_models/appointments/appointment_details_vm.dart';
import 'package:project_docere/domain/view_models/appointments/appointment_edit_vm.dart';
import 'package:project_docere/domain/view_models/appointments/confirm_appointment_vm.dart';
import 'package:project_docere/domain/view_models/doctors/doctor_list_vm.dart';
import 'package:project_docere/framework/helpers/network_info_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/helpers/netork_info_helper.dart';
import 'domain/use_cases/doctors/get_list_doctors_use_case.dart';
import 'domain/view_models/appointments/appointment_list_secretary_vm.dart';
import 'domain/view_models/appointments/appointment_list_vm.dart';
import 'domain/view_models/appointments/create_appointment_vm.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Session
  final _currentTestSession = //PatientSessionTmp();
      SecretarySessionTmp();
  sl.registerLazySingleton<Session>(
    () => _currentTestSession,
  );

  // Data sources
  sl.registerLazySingleton<IDoctorLocalDataSource>(
    () => DoctorDatabaseDataSource(),
  );
  sl.registerLazySingleton<IDoctorRemoteDataSource>(
    () => DoctorFirestoreDataSource(sl()),
  );
  sl.registerLazySingleton<IAppointmentRemoteDataSource>(
    () => AppointmentFirestoreDataStore(sl()),
  );

  // Repositories
  sl.registerLazySingleton<IPatientRepository>(
    () => PatientRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
      connectionChecker: sl(),
    ),
  );

  sl.registerLazySingleton<IDoctorRepository>(
    () => DoctorRepository(
      remoteDataSource: sl(),
      connectionChecker: sl(),
    ),
  );

  sl.registerLazySingleton<IAppointmentRepository>(
    () => AppointmentRepository(dataStore: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetListDoctorsUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentCalendarUseCase(sl()));
  sl.registerLazySingleton(() => CreateAppointmentUseCase(sl(), sl()));
  sl.registerLazySingleton(() => GetAppointmentsUseCase(sl()));
  sl.registerLazySingleton(() => ChangeAppointmentStatusUseCase(sl()));
  sl.registerLazySingleton(() => ChangeAppointmentTimeUseCase(sl(), sl()));
  sl.registerFactory(() => GetSecretaryDoctorUseCase(sl()));
  sl.registerFactory(() => GetDoctorAppointmentsUseCase(sl()));

  // View models
  sl.registerFactory(() => DoctorListViewModel(sl(), sl(), sl()));
  sl.registerFactory(() => CreateAppointmentViewModel(sl(), sl()));
  sl.registerFactory(() => ConfirmAppointmentViewModel(sl()));
  sl.registerFactory(() => AppointmentListViewModel(sl()));
  sl.registerFactory(() => AppointmentListSecretaryViewModel(sl(), sl(), sl()));
  sl.registerFactory(() => AppointmentDetailsViewModel(sl()));
  sl.registerFactory(() => AppointmentEditViewModel(sl(), sl()));
  // Core

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  // http
  sl.registerLazySingleton<INetworkInfoHelper>(() => NetworkInfoHelper());
  // Firestore
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
}
