import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/view_models/appointments/appointment_details_vm.dart';
import 'package:project_docere/framework/ui/appointments/appointment_edit_pg.dart';
import 'package:project_docere/framework/ui/widgets/doctor_card_wg.dart';
import 'package:project_docere/framework/ui/widgets/round_text_wg.dart';
import 'package:project_docere/framework/ui/widgets/secretary_card.dart';
import 'package:project_docere/framework/ui/widgets/simple_center_card_wg.dart';
import 'package:project_docere/framework/ui/widgets/time_widget.dart';
import 'package:project_docere/injection_container.dart';
import 'package:provider/provider.dart';

class AppointmentDetailsArguments {
  final Appointment appointment;

  AppointmentDetailsArguments({@required this.appointment});
}

class AppointmentDetailsPage extends StatelessWidget {
  static final String routeName = "/appointmentDetails";

  @override
  Widget build(BuildContext context) {
    final AppointmentDetailsArguments args =
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
                DoctorCardWidget(doctor: viewModel.doctor),
                TimeWidget(
                  time: viewModel.timeToStart,
                  inOrderOfArrival: viewModel.isAttentionOrderInOrderOfArrival,
                ),
                SimpleCenterCard(
                    name: viewModel.centerName,
                    address: viewModel.centerAddress),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Text(
                            "En turno",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          RoundText("3 P"),
                        ],
                      ),
                      GestureDetector(
                        child: RoundText(
                          "Check in",
                          enabled: viewModel.canBeCheckedIn,
                        ),
                        onTap: viewModel.canBeCheckedIn
                            ? () {
                                viewModel.checkIn();
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
                Container(
                    width: double.maxFinite,
                    child: Text(
                      "Secretaria que te está atendiendo",
                      textAlign: TextAlign.start,
                    )),
                SecretaryCard(
                  name: viewModel.secretaryName,
                  phoneNumber: viewModel.secretaryPhone,
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: ElevatedButton(
                    onPressed: viewModel.canBeEdited
                        ? () {
                            Navigator.pushNamed(
                              context,
                              AppointmentEditPage.routeName,
                              arguments: AppointmentEditArguments(
                                viewModel.getAppointment,
                              ),
                            );
                          }
                        : null,
                    child: Text("Editar"),
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
