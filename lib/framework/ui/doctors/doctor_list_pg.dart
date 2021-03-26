import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/colors.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/session.dart';
import 'package:project_docere/domain/view_models/doctors/doctor_list_vm.dart';
import 'package:project_docere/framework/ui/create_appointment/create_appointment_pg.dart';
import 'package:project_docere/framework/ui/widgets/doctor_card_wg.dart';
import 'package:project_docere/texts.dart';
import 'package:provider/provider.dart';

class DoctorListPage extends StatelessWidget {
  final Function(Doctor) onDoctorSelected;

  DoctorListPage({this.onDoctorSelected});

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

    void _navigateAppointmentList(BuildContext context, Doctor doctor) {
      if (this.onDoctorSelected != null) {
        this.onDoctorSelected(doctor);
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: _DoctorListAppBar(),
      ),
      body: ListView.builder(
        itemCount: _doctors.length,
        itemBuilder: (BuildContext context, int index) {
          switch (viewModel.sessionRol) {
            case Rol.Secretary:
              {
                return DoctorSecretaryCard(
                  doctor: _doctors[index],
                  onTap: (Doctor doctor) {
                    _navigateAppointmentList(context, doctor);
                  },
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

class _DoctorListAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MedAppColors.blue, boxShadow: [
        BoxShadow(
          color: MedAppColors.gray2,
          offset: Offset(0.0, 1.0), //(x,y)
          blurRadius: 6.0,
        )
      ]),
      padding: EdgeInsets.only(left: 25),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                "¡Hola \$usuario!",
                style: MedAppTextStyle.title().copyWith(color: Colors.white),
              ),
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.wb_sunny_rounded,
                color: Colors.white,
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Aquí te mostramos tus doctores ",
            style: MedAppTextStyle.header3().copyWith(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
