import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/domain/extensions.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/view_models/appointments/appointment_list_vm.dart';
import 'package:project_docere/framework/ui/appointments/patient/appointment_details_pg.dart';
import 'package:project_docere/injection_container.dart';
import 'package:provider/provider.dart';

class AppointmentListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = sl<AppointmentListViewModel>();
        viewModel.loadAppointments();
        return viewModel;
      },
      child: Consumer<AppointmentListViewModel>(
        builder: (_, viewModel, __) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Citas"),
            ),
            body: ListView.builder(
              itemCount: viewModel.appointmentCount,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppointmentDetailsPage.routeName,
                      arguments: AppointmentDetailsArguments(
                        appointment: viewModel.appointmentAt(index),
                      ),
                    );
                  },
                  child: PatientAppointmentCard.fromAppointment(
                    viewModel.appointmentAt(index),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class PatientAppointmentCard extends StatelessWidget {
  final String doctorName;
  final String doctorSpecialty;
  final DateTime appointmentAt;
  final bool isAttentionOrderHour;
  final String centerName;

  const PatientAppointmentCard({
    Key key,
    @required this.doctorName,
    @required this.doctorSpecialty,
    @required this.appointmentAt,
    @required this.isAttentionOrderHour,
    @required this.centerName,
  }) : super(key: key);

  factory PatientAppointmentCard.fromAppointment(Appointment appointment) {
    return PatientAppointmentCard(
      doctorName: appointment.doctor.fullName,
      doctorSpecialty: appointment.doctor.specialty,
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
                    "https://cdn2.iconfinder.com/data/icons/avatar-business-people-set-one/128/avatar-25-512.png",
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
                        doctorName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(doctorSpecialty),
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
