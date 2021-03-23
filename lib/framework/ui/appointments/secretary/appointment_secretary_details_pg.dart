import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/models/insurance.dart';
import 'package:project_docere/domain/routers/routes.dart';
import 'package:project_docere/domain/view_models/appointments/appointment_details_vm.dart';
import 'package:project_docere/framework/ui/appointments/secretary/appointment_authorization_wg.dart';
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
                Text(
                  viewModel.patientDetails.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(viewModel.appointmentStatus),
                TimeWidget(
                  time: viewModel.timeToStart,
                  inOrderOfArrival: viewModel.isAttentionOrderInOrderOfArrival,
                ),
                Text("Info del paciente"),
                GestureDetector(
                  onTap: viewModel.canAddInsurance
                      ? () {
                          Routes.navigateToAppointmentAuthorization(
                            context,
                            AppointmentAuthorizationPage.routName,
                            AppointmentAuthorizationArguments(
                              (insurance) {
                                viewModel.setInsurance = insurance;
                              },
                            ),
                          );
                        }
                      : null,
                  child: Container(
                    child: Column(
                      children: [
                        Text("Seguro"),
                        _InsuranceVisor(viewModel.getInsurance)
                      ],
                    ),
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

class _InsuranceVisor extends StatelessWidget {
  final Insurance _insurance;

  _InsuranceVisor(this._insurance);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_insurance == null) {
      child = Icon(
        Icons.image,
        size: 60,
      );
    } else {
      if (_insurance.isPrivate == true) {
        child = Center(
          child: Text("Paciente privado"),
        );
      } else {
        child = Image(
          image: AssetImage(_insurance.insuranceProvider.asset()),
        );
      }
    }

    return SizedBox(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
        elevation: 10,
      ),
      width: 200,
      height: 120,
    );
  }
}
