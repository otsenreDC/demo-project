import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_docere/framework/ui/appointments/patient/appointment_details_pg.dart';
import 'package:project_docere/framework/ui/appointments/secretary/appointment_authorization_wg.dart';
import 'package:project_docere/framework/ui/create_appointment/create_appointment_pg.dart';
import 'package:provider/provider.dart';

import 'domain/view_models/doctors/doctor_list_vm.dart';
import 'framework/ui/appointments/patient/appointment_edit_pg.dart';
import 'framework/ui/appointments/secretary/appointment_secretary_details_pg.dart';
import 'framework/ui/home/home_pg.dart';
import 'injection_container.dart';

class MedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<DoctorListViewModel>())
      ],
      child: MaterialApp(
        routes: {
          HomePage.routeName: (context) => HomePage(),
          CreateAppointmentPage.routeName: (context) => CreateAppointmentPage(),
          AppointmentDetailsPage.routeName: (context) =>
              AppointmentDetailsPage(),
          AppointmentSecretaryDetailsPage.routeName: (context) =>
              AppointmentSecretaryDetailsPage(),
          AppointmentEditPage.routeName: (context) => AppointmentEditPage(),
          AppointmentAuthorizationPage.routName: (context) =>
              AppointmentAuthorizationPage()
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Segoe',
        ),
      ),
    );
  }
}
