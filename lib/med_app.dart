import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_docere/framework/ui/appointments/appointment_details_pg.dart';
import 'package:project_docere/framework/ui/create_appointment/create_appointment_pg.dart';
import 'package:provider/provider.dart';

import 'framework/ui/doctors/doctor_list_vm.dart';
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
              AppointmentDetailsPage()
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Segoe',
        ),
      ),
    );
  }
}
