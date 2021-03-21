import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/view_models/appointments/appointment_details_vm.dart';
import 'package:project_docere/framework/ui/widgets/doctor_card_wg.dart';
import 'package:project_docere/framework/ui/widgets/simple_center_card_wg.dart';
import 'package:project_docere/framework/ui/widgets/time_widget.dart';
import 'package:project_docere/injection_container.dart';
import 'package:provider/provider.dart';

class AppointmentSecretaryDetailsArguments {
  final Appointment appointment;

  AppointmentSecretaryDetailsArguments({@required this.appointment});
}

class AppointmentSecretaryDetailsPage extends StatelessWidget {
  static final String routeName = "/appointmentSecretaryDetails";

  @override
  Widget build(BuildContext context) {
    final AppointmentSecretaryDetailsArguments args =
        ModalRoute.of(context).settings.arguments;

    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = sl<AppointmentDetailsViewModel>();
        viewModel.init(args.appointment);
        return viewModel;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detalles"),
        ),
        body: Consumer<AppointmentDetailsViewModel>(
          builder: (_, viewModel, __) {
            return ListView(
              children: [
                Text(viewModel.patientDetails.name),
                Text(viewModel.appointmentStatus),
                TimeWidget(
                  time: viewModel.timeToStart,
                  inOrderOfArrival: viewModel.isAttentionOrderInOrderOfArrival,
                ),
                Text("Info del paciente"),
                Container(
                  child: Column(
                    children: [
                      Text("Seguro"),
                      SizedBox(
                        child: Container(
                          color: Colors.grey,
                        ),
                        width: 250,
                        height: 100,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.fromLTRB(60, 10, 60, 10),
                  color: Colors.grey,
                  child: Column(
                    children: [
                      Text(viewModel.patientDetails.phone),
                      Text(viewModel.patientDetails.personalId),
                      Text(viewModel.patientDetails.birthday),
                      Text(viewModel.patientDetails.city)
                    ],
                  ),
                ),
                DoctorPatientCard(doctor: viewModel.doctor),
                SimpleCenterCard(
                    name: viewModel.centerName,
                    address: viewModel.centerAddress),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: ElevatedButton(
                    onPressed: viewModel.canLetThePatientPass
                        ? () {
                            viewModel.letThePatientSeeTheDoctor();
                          }
                        : null,
                    child: Text("Hacerlo pasar"),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: ElevatedButton(
                        onPressed: viewModel.canBeCancelled
                            ? () {
                                viewModel.cancel();
                              }
                            : null,
                        child: Text("Cancelar cita"))),
              ],
            );
          },
        ),
      ),
    );
  }
}
