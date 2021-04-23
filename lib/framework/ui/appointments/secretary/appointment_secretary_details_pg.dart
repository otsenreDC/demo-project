import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/models/insurance.dart';
import 'package:project_docere/domain/routers/routes.dart';
import 'package:project_docere/domain/view_models/appointments/appointment_details_vm.dart';
import 'package:project_docere/framework/ui/appointments/secretary/appointment_authorization_wg.dart';
import 'package:project_docere/framework/ui/profile/profile_pg.dart';
import 'package:project_docere/framework/ui/widgets/doctor_card_wg.dart';
import 'package:project_docere/framework/ui/widgets/phone_tile.dart';
import 'package:project_docere/framework/ui/widgets/simple_center_card_wg.dart';
import 'package:project_docere/injection_container.dart';
import 'package:project_docere/texts.dart';
import 'package:provider/provider.dart';

import '../../../../colors.dart';

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

    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Container(
        padding: EdgeInsets.only(top: 40),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black87,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              )
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            color: Colors.white,
          ),
          child: ChangeNotifierProvider(
            create: (_) {
              final viewModel = sl<AppointmentDetailsViewModel>();
              viewModel.init(args.appointment);
              return viewModel;
            },
            child: Consumer<AppointmentDetailsViewModel>(
              builder: (_, viewModel, __) {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(45),
                      topLeft: Radius.circular(45)),
                  child: Container(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                maxRadius: 20,
                                minRadius: 20,
                                backgroundImage: NetworkImage(
                                  "https://image.flaticon.com/icons/png/512/1430/1430453.png",
                                ),
                              ),
                              SizedBox(width: 16),
                              Text(
                                viewModel.patientDetails.name,
                                style: MedAppTextStyle.header3(),
                              ),
                              Spacer(),
                              Container(
                                width: 80,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: MedAppColors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.only(left: 4, right: 4),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      "3:00 PM",
                                      textAlign: TextAlign.center,
                                      style: MedAppTextStyle.label().copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 16, 30, 0),
                          child: Row(
                            children: [
                              Text(
                                viewModel.appointmentStatus,
                                style: MedAppTextStyle.body()
                                    .copyWith(fontWeight: FontWeight.w900),
                              ),
                              Spacer(),
                              ElevatedButton(
                                  onPressed: null, child: Text("Check in"))
                            ],
                          ),
                        ),
                        // TimeWidget(
                        //   time: viewModel.timeToStart,
                        //   inOrderOfArrival:
                        //       viewModel.isAttentionOrderInOrderOfArrival,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 8, bottom: 8),
                          child: Text(
                            "Seguro",
                            style: MedAppTextStyle.header3(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text("El paciente es privado"),
                              style: ElevatedButton.styleFrom(
                                textStyle: MedAppTextStyle.header3(),
                                primary: MedAppColors.lighterBlue, // background
                                onPrimary: MedAppColors.lightBlue,
                                shadowColor: Colors.transparent,
                              )),
                        ),
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 30.0),
                              child: _InsuranceVisor(viewModel.getInsurance),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 16, bottom: 8),
                          child: Text(
                            "Cédula",
                            style: MedAppTextStyle.header3(),
                          ),
                        ),
                        _LabelItem(viewModel.patientDetails.personalId),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 16, bottom: 8),
                          child: Text(
                            "Fecha de Nacimiento",
                            style: MedAppTextStyle.header3(),
                          ),
                        ),
                        BirthdayTile(null),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 16, bottom: 8),
                          child: Text(
                            "Télefono/Celular",
                            style: MedAppTextStyle.header3(),
                          ),
                        ),
                        PhoneTile("000-000-0000"),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 16, bottom: 8),
                          child: Text(
                            "Dirección",
                            style: MedAppTextStyle.header3(),
                          ),
                        ),
                        _LabelItem("Calle Los Pepines #10, Arroyo Hondo"),
                        DoctorPatientCard(doctor: viewModel.doctor),
                        SimpleCenterCard(
                            name: viewModel.centerName,
                            address: viewModel.centerAddress),
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
                            margin: EdgeInsets.only(
                                left: 30, right: 30, bottom: 20),
                            child: ElevatedButton(
                                onPressed: viewModel.canBeCancelled
                                    ? () {
                                        viewModel.cancel();
                                      }
                                    : null,
                                child: Text("Cancelar cita"))),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _LabelItem extends StatelessWidget {
  final String _text;
  final EdgeInsets margin;

  _LabelItem(
    this._text, {
    this.margin = const EdgeInsets.fromLTRB(30, 8, 30, 8),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: MedAppColors.black247,
      ),
      child: Text(
        _text,
        style: MedAppTextStyle.label(),
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
      child = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Agregar",
            style: MedAppTextStyle.header3().copyWith(fontSize: 12),
          ),
          Icon(
            Icons.add,
            size: 15,
          )
        ],
      );
    } else {
      if (_insurance.isPrivate == true) {
        child = Center(
          child: Text(
            "Paciente privado",
            style: TextStyle(
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        child = Image(
          image: AssetImage(_insurance.insuranceProvider.asset()),
        );
      }
    }

    return SizedBox(
      child: Card(
        color: MedAppColors.black247,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
      width: 200,
      height: 120,
    );
  }
}
