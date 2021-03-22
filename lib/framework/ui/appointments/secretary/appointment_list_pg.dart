import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/domain/extensions.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/view_models/appointments/appointment_list_secretary_vm.dart';
import 'package:project_docere/framework/ui/appointments/secretary/appointment_secretary_details_pg.dart';
import 'package:project_docere/framework/ui/widgets/doctor_card_wg.dart';
import 'package:project_docere/injection_container.dart';
import 'package:provider/provider.dart';

class AppointmentListSecretaryPage extends StatelessWidget {
  static String routeName = "appointments/secretary";

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
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 60),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 90,
                      child: Center(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: viewModel.doctorsCount,
                          itemBuilder: (context, index) => Container(
                            width: 300,
                            child: DoctorSecretaryCard(
                              doctor: viewModel.doctorAt(index),
                              isSelected:
                                  viewModel.getSelectedDoctorPosition == index,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 30,
                      color: Colors.black54,
                    ),
                    viewModel.appointmentCount == 0
                        ? Text("Doctor no seleccionado")
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 20, //viewModel.appointmentCount,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppointmentSecretaryDetailsPage.routeName,
                                    arguments:
                                        AppointmentSecretaryDetailsArguments(
                                      appointment: viewModel.appointmentAt(0),
                                    ),
                                  );
                                },
                                child: SecretaryAppointmentCard.fromAppointment(
                                  viewModel.appointmentAt(0),
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
                    onPressed: () {},
                    child: Text("Nueva cita"),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class SecretaryAppointmentCard extends StatelessWidget {
  final String name;
  final DateTime appointmentAt;
  final bool isAttentionOrderHour;
  final String centerName;

  const SecretaryAppointmentCard({
    Key key,
    @required this.name,
    @required this.appointmentAt,
    @required this.isAttentionOrderHour,
    @required this.centerName,
  }) : super(key: key);

  factory SecretaryAppointmentCard.fromAppointment(Appointment appointment) {
    return SecretaryAppointmentCard(
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
