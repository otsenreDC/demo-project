import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/domain/models/center_info.dart';
import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/ui_state.dart';
import 'package:project_docere/domain/routers/routes.dart';
import 'package:project_docere/domain/view_models/appointments/confirm_appointment_vm.dart';
import 'package:project_docere/framework/ui/widgets/day_widget.dart';
import 'package:project_docere/framework/ui/widgets/doctor_card_wg.dart';
import 'package:project_docere/framework/ui/widgets/error_wg.dart';
import 'package:project_docere/framework/ui/widgets/loadgin_wg.dart';
import 'package:project_docere/framework/ui/widgets/secretary_card.dart';
import 'package:project_docere/framework/ui/widgets/simple_center_card_wg.dart';
import 'package:project_docere/framework/ui/widgets/time_widget.dart';
import 'package:provider/provider.dart';

import '../../../injection_container.dart';

class ConfirmAppointmentPage extends StatelessWidget
    with WidgetsBindingObserver {
  final Doctor doctor;
  final CenterInfo centerInfo;
  final Day day;
  final DaySlot daySlot;
  final DateTime dateTime;

  ConfirmAppointmentPage({
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
                  children: [
                    Text("Fecha"),
                    DayWidget(day: viewModel.appointmentDate),
                    Text("Hora"),
                    TimeWidget(
                      time: viewModel.getStartHour(),
                      inOrderOfArrival:
                          viewModel.appointmentSlot.inOrderOfArrival,
                    ),
                    Text("Doctor"),
                    DoctorPatientCard(doctor: viewModel.doctor),
                    Text("Centro Médico"),
                    SimpleCenterCard(
                        name: viewModel.centerName,
                        address: viewModel.centerAddress),
                    Text("Secretaria"),
                    SecretaryCard(
                      name: viewModel.secretaryName,
                      phoneNumber: viewModel.secretaryPhoneNumber,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          viewModel.createAppointment();
                        },
                        child: Text("Hacer Cita"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Routes.backHome(context);
                        },
                        child: Text("Cancelar"),
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                      ),
                    ),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Tu cita ha sido asignada con éxito."),
          SizedBox(
            height: 30,
          ),
          Icon(
            Icons.done,
            color: Colors.indigo,
            size: 200,
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
