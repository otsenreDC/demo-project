import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'framework/ui/doctors/doctor_list_vm.dart';
import 'framework/ui/home/home_pg.dart';
import 'injection_container.dart';

class MedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: sl<DoctorListViewModel>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          fontFamily: 'Segoe',
        ),
        home: HomePage(),
      ),
    );
  }
}
