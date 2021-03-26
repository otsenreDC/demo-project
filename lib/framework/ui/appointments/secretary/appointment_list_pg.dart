import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/domain/extensions.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/view_models/appointments/appointment_list_secretary_vm.dart';
import 'package:project_docere/framework/ui/appointments/secretary/appointment_secretary_details_pg.dart';
import 'package:project_docere/framework/ui/create_appointment/create_appointment_pg.dart';
import 'package:project_docere/framework/ui/widgets/summary_item.dart';
import 'package:project_docere/injection_container.dart';
import 'package:project_docere/texts.dart';
import 'package:provider/provider.dart';

import '../../../../colors.dart';

class AppointmentListSecretaryPage extends StatelessWidget {
  static String routeName = "appointments/secretary";

  void _navigateCreateAppointment(BuildContext context, Doctor doctor) {
    Navigator.pushNamed(
      context,
      CreateAppointmentPage.routeName,
      arguments: CreateAppointmentArguments(doctor: doctor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = sl<AppointmentListSecretaryViewModel>();
        viewModel.init();
        return viewModel;
      },
      child: Consumer<AppointmentListSecretaryViewModel>(
        builder: (_, viewModel, __) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Citas"),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 30),
                          Text(
                            "Hoy",
                            style: MedAppTextStyle.header1(),
                          ),
                          SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: MedAppColors.lighterBlue,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: EdgeInsets.all(4),
                            height: 30,
                            child: Center(
                              child: Text(
                                "8899",
                                style: MedAppTextStyle.header1()
                                    .copyWith(color: MedAppColors.blue),
                              ),
                            ),
                          ),
                          Spacer(),
                          _DoctorItem("Luis Javier", "Neumólogo"),
                          SizedBox(width: 30),
                        ],
                      ),
                      _PatientsSummary(),
                      viewModel.appointmentCount == 0
                          ? Text("Doctor no seleccionado")
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: viewModel.appointmentCount,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppointmentSecretaryDetailsPage.routeName,
                                      arguments:
                                          AppointmentSecretaryDetailsArguments(
                                        appointment:
                                            viewModel.appointmentAt(index),
                                      ),
                                    );
                                  },
                                  child:
                                      _SecretaryAppointmentCard.fromAppointment(
                                    viewModel.appointmentAt(index),
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
                    width: double.infinity,
                    color: Colors.white,
                    child: OutlinedButton(
                      child: Text("Nueva cita"),
                      onPressed: viewModel.canCreateAppointment
                          ? () {
                              final doctor = viewModel.getSelectedDoctor;
                              _navigateCreateAppointment(context, doctor);
                            }
                          : null,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PatientsSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 27, right: 27, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: MedAppColors.lighterBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      height: 72,
      child: Row(
        children: [
          SummaryItem(
            "Atendido",
            2,
            labelTextColor: MedAppColors.blue,
            valueTextColor: MedAppColors.lightBlue,
          ),
          SummaryItem(
            "En espera",
            4,
            labelTextColor: MedAppColors.blue,
            valueTextColor: MedAppColors.lightBlue,
          ),
          SummaryItem(
            "Futuro",
            2,
            labelTextColor: MedAppColors.blue,
            valueTextColor: MedAppColors.lightBlue,
          ),
        ],
      ),
    );
  }
}

class _DoctorItem extends StatelessWidget {
  final String _name;
  final String _specialty;
  final double width;

  _DoctorItem(this._name, this._specialty, {this.width = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: MedAppColors.lighterBlue,
      ),
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: MedAppColors.lightBlue,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          // width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _name,
                    style: MedAppTextStyle.label().copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _specialty,
                    style:
                        MedAppTextStyle.label().copyWith(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                width: 8,
              ),
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                  "https://cdn2.iconfinder.com/data/icons/avatar-business-people-set-one/128/avatar-25-512.png",
                ),
              ),
            ],
          )),
    );
  }
}

class _SecretaryAppointmentCard extends StatelessWidget {
  final String name;
  final DateTime appointmentAt;
  final bool isAttentionOrderHour;
  final String centerName;

  const _SecretaryAppointmentCard({
    Key key,
    @required this.name,
    @required this.appointmentAt,
    @required this.isAttentionOrderHour,
    @required this.centerName,
  }) : super(key: key);

  factory _SecretaryAppointmentCard.fromAppointment(Appointment appointment) {
    return _SecretaryAppointmentCard(
      name: appointment.patient.fullName,
      appointmentAt: appointment.appointmentAt.toDate(),
      isAttentionOrderHour: appointment.isAttentionByHour,
      centerName: appointment.centerInfo.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                // color: Colors.indigo,
                child: CircleAvatar(
                  maxRadius: 25,
                  minRadius: 25,
                  backgroundImage: NetworkImage(
                    "https://image.flaticon.com/icons/png/512/1430/1430453.png",
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        centerName,
                        maxLines: 3,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 80,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.only(left: 4, right: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        isAttentionOrderHour
                            ? DateTimeHelper.format(appointmentAt,
                                pattern: DATE_FORMAT_TIME)
                            : "Orden",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
