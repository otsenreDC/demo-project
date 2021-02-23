import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/framework/ui/doctors/doctor_list_vm.dart';
import 'package:provider/provider.dart';

import 'doctor_cart_wg.dart';

class DoctorListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Doctor> _doctors =
        Provider.of<DoctorListViewModel>(context).getDoctors;

    return Scaffold(
      body: ListView.builder(
        itemCount: _doctors.length,
        itemBuilder: (BuildContext context, int index) => DoctorCardWidget(
          doctor: _doctors[index],
        ),
      ),
    );
  }
}
