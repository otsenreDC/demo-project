import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/session.dart';
import 'package:project_docere/domain/view_models/doctors/doctor_list_vm.dart';
import 'package:project_docere/framework/ui/create_appointment/create_appointment_pg.dart';
import 'package:project_docere/framework/ui/widgets/doctor_card_wg.dart';
import 'package:provider/provider.dart';

class DoctorListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DoctorListViewModel>(context);
    List<Doctor> _doctors = viewModel.getDoctors;

    void _navigateCreateAppointment(BuildContext context, Doctor doctor) {
      Navigator.pushNamed(
        context,
        CreateAppointmentPage.routeName,
        arguments: CreateAppointmentArguments(doctor: doctor),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Doctores"),
      ),
      body: ListView.builder(
        itemCount: _doctors.length,
        itemBuilder: (BuildContext context, int index) {
          switch (viewModel.sessionRol) {
            case Rol.Secretary:
              {
                return DoctorSecretaryCard(
                  doctor: _doctors[index],
                  onTap: null,
                );
              }
            case Rol.Patient:
              {
                return DoctorPatientCard(
                  doctor: _doctors[index],
                  onTap: (Doctor doctor) {
                    _navigateCreateAppointment(context, doctor);
                  },
                );
              }
            default:
              {
                return Text("Rol desconocido");
              }
          }
        },
      ),
    );
  }
}
