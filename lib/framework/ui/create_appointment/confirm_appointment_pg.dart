import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/colors.dart';
import 'package:project_docere/domain/models/center_info.dart';
import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/patient.dart';
import 'package:project_docere/domain/models/ui_state.dart';
import 'package:project_docere/domain/routers/routes.dart';
import 'package:project_docere/domain/view_models/appointments/confirm_appointment_vm.dart';
import 'package:project_docere/framework/ui/profile/profile_pg.dart';
import 'package:project_docere/framework/ui/widgets/day_widget.dart';
import 'package:project_docere/framework/ui/widgets/doctor_item.dart';
import 'package:project_docere/framework/ui/widgets/error_wg.dart';
import 'package:project_docere/framework/ui/widgets/loadgin_wg.dart';
import 'package:project_docere/framework/ui/widgets/simple_center_card_wg.dart';
import 'package:project_docere/framework/ui/widgets/text_tile.dart';
import 'package:project_docere/framework/ui/widgets/time_widget.dart';
import 'package:project_docere/framework/ui/widgets/vertical_spacer.dart';
import 'package:project_docere/styles.dart';
import 'package:project_docere/texts.dart';
import 'package:provider/provider.dart';

import '../../../injection_container.dart';

class ConfirmAppointmentPage extends StatelessWidget
    with WidgetsBindingObserver {
  final Doctor doctor;
  final CenterInfo centerInfo;
  final Day day;
  final DaySlot daySlot;
  final DateTime dateTime;
  final Patient patient;

  ConfirmAppointmentPage({
    @required this.patient,
    @required this.doctor,
    @required this.centerInfo,
    @required this.day,
    @required this.daySlot,
    @required this.dateTime,
  });

  @override
  Future<bool> didPopRoute() {
    WidgetsBinding.instance.removeObserver(this);
    return super.didPopRoute();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final ConfirmAppointmentViewModel viewModel =
            sl<ConfirmAppointmentViewModel>();
        viewModel.init(
          doctor,
          centerInfo,
          day,
          daySlot,
          dateTime,
          patient,
        );
        return viewModel;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Confirmando cita"),
        ),
        body: Consumer<ConfirmAppointmentViewModel>(
          builder: (_, viewModel, __) {
            final _UIState = viewModel.getUIState;
            if (_UIState is UIError) {
              return Error(message: "ERROR CARGANDO DATOS");
            }

            if (_UIState is UILoading) {
              return Loading(message: "CREANDO CITA");
            }

            if (_UIState is UIShowData) {
              if (_UIState.data == true) {
                return _AppointmentCreated(
                  callback: () => {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => {Routes.backHome(context)},
                    )
                  },
                );
              } else {
                return ListView(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  children: [
                    VerticalSpacer(30),
                    Text(
                      "Datos del paciente",
                      style: MedAppTextStyle.title()
                          .copyWith(color: MedAppColors.text),
                    ),
                    VerticalSpacer(25),
                    Text(
                      "Nombre",
                      style: MedAppTextStyle.header2(),
                    ),
                    TextTile(viewModel.patientName),
                    VerticalSpacer(20),
                    Text(
                      "Teléfono",
                      style: MedAppTextStyle.header2(),
                    ),
                    PhoneTile(viewModel.patientPhoneNumber),
                    VerticalSpacer(20),
                    Text(
                      "Email",
                      style: MedAppTextStyle.header2(),
                    ),
                    TextTile(viewModel.patientEmail),
                    VerticalSpacer(20),
                    Text(
                      "Cédula",
                      style: MedAppTextStyle.header2(),
                    ),
                    TextTile(viewModel.patientPersonalId),
                    ////APPOINTMENT SECTION/////
                    VerticalSpacer(30),
                    Text(
                      "Sobre la cita",
                      style: MedAppTextStyle.title().copyWith(
                        color: MedAppColors.text,
                      ),
                    ),
                    VerticalSpacer(30),
                    Text(
                      "Doctor",
                      style: MedAppTextStyle.header2(),
                    ),
                    DoctorItem(
                      viewModel.doctor.fullName,
                      viewModel.doctor.specialty,
                    ),
                    VerticalSpacer(20),
                    Text(
                      "Centro Médico",
                      style: MedAppTextStyle.header2(),
                    ),
                    SimpleCenterCard(
                      name: viewModel.centerName,
                      address: viewModel.centerAddress,
                    ),
                    VerticalSpacer(20),
                    Text(
                      "Hora",
                      style: MedAppTextStyle.header2(),
                    ),
                    TimeWidget(
                      time: viewModel.getStartHour(),
                      inOrderOfArrival:
                          viewModel.appointmentSlot.inOrderOfArrival,
                    ),
                    VerticalSpacer(20),
                    Text(
                      "Fecha",
                      style: MedAppTextStyle.header2(),
                    ),
                    DayWidget(day: viewModel.appointmentDate),
                    // Text("Secretaria"),
                    // SecretaryCard(
                    //   name: viewModel.secretaryName,
                    //   phoneNumber: viewModel.secretaryPhoneNumber,
                    // ),
                    VerticalSpacer(40),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.createAppointment();
                      },
                      child: Text("Hacer Cita"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Routes.backHome(context);
                      },
                      child: Text("Cancelar"),
                      style: MedAppStyles.lighBlueButtonStyle,
                    ),
                    VerticalSpacer(50),
                  ],
                );
              }
            }

            return Error(message: "Error cargango página");
          },
        ),
      ),
    );
  }
}

class _AppointmentCreated extends StatelessWidget {
  final Function callback;

  _AppointmentCreated({this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(
            flex: 2,
          ),
          Text(
            "¡Cita confirmada!",
            style: MedAppTextStyle.title().copyWith(
              color: MedAppColors.text,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Tu cita ha sido asignada con éxito.",
            style: MedAppTextStyle.header1().copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: MedAppColors.green),
            child: Icon(
              Icons.done,
              color: Colors.white,
              size: 150,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: callback,
              child: Text("Entendido"),
            ),
          ),
          Spacer(
            flex: 4,
          ),
        ],
      ),
    );
  }
}
