import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/domain/extensions.dart';
import 'package:project_docere/domain/models/appointment.dart';
import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/routers/routes.dart';
import 'package:project_docere/domain/view_models/appointments/appointment_edit_vm.dart';
import 'package:project_docere/framework/ui/widgets/hours_wg.dart';
import 'package:project_docere/framework/ui/widgets/time_widget.dart';
import 'package:project_docere/injection_container.dart';
import 'package:provider/provider.dart';

class AppointmentEditArguments {
  final Appointment appointment;

  AppointmentEditArguments(this.appointment);
}

class AppointmentEditPage extends StatelessWidget {
  static final String routeName = "/appointmentEdition";

  @override
  Widget build(BuildContext context) {
    final AppointmentEditArguments args =
        ModalRoute.of(context).settings.arguments;

    return ChangeNotifierProvider(
      create: (_) {
        final AppointmentEditViewModel viewModel =
            sl<AppointmentEditViewModel>();
        viewModel.init(args.appointment);
        return viewModel;
      },
      child: Consumer<AppointmentEditViewModel>(builder: (_, viewModel, __) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              width: double.infinity,
              child: _contentWidget(
                viewModel,
                viewModel.getDay,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _contentWidget(AppointmentEditViewModel viewModel, Day day) {
    if (viewModel.updateDone) {
      return _AppointmentModified(
        viewModel.currentTime,
        viewModel.isInOrderOfArrival,
      );
    }

    if (viewModel.confirmNewSlot) {
      return _ConfirmChangeWidget(
        viewModel,
      );
    }

    return _ChangeTimeWidget(viewModel, day);
  }
}

class _ChangeTimeWidget extends StatelessWidget {
  final AppointmentEditViewModel _viewModel;
  final Day day;

  _ChangeTimeWidget(
    this._viewModel,
    this.day,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Hora actual de tu cita"),
        TimeWidget(
          time: _viewModel.currentTime,
          inOrderOfArrival: false,
        ),
        Text("Más horas disponibles"),
        Container(
          padding: EdgeInsets.only(left: 50, right: 50),
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
                primary: false ? Colors.white : Colors.blue[800],
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                backgroundColor: false == true
                    ? Theme.of(context).accentColor
                    : Colors.lightBlue[100]),
            onPressed: () {
              _viewModel.newSlot = DaySlot.inOrderOfArrival();
            },
            child: Text("Orden de llegada"),
          ),
        ),
        Container(
          child: HoursWidget(
            day: day,
            selectedHour: null,
            onTap: (value) {
              _viewModel.newSlot = value;
            },
          ),
        )
      ],
    );
  }
}

class _ConfirmChangeWidget extends StatelessWidget {
  final AppointmentEditViewModel _viewModel;

  _ConfirmChangeWidget(this._viewModel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Nuevo horario de tu cita"),
        TimeWidget(
          time: _viewModel.newSlot?.start?.toDate(),
          inOrderOfArrival: _viewModel.newSlot?.inOrderOfArrival,
        ),
        Text("Anteriormente"),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 100, right: 100),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.lightBlue[100],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(
              DateTimeHelper.format(_viewModel.currentTime,
                  pattern: "h  :  mm   a"),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              )),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 30, right: 30),
          child: ElevatedButton(
            onPressed: _viewModel.changeTime,
            child: Text(
              "Guardar nueva hora",
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 30, right: 30),
          child: OutlinedButton(
            onPressed: _viewModel.cancelConfirmation,
            child: Text("Buscar otra hora"),
          ),
        )
      ],
    );
  }
}

class _AppointmentModified extends StatelessWidget {
  final DateTime _appointmentAt;
  final bool _inOrderOfArrival;

  _AppointmentModified(this._appointmentAt, this._inOrderOfArrival);

  Future<bool> _onWillPop(BuildContext context) async {
    Routes.backHome(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Column(
        children: [
          Text("¡Tu hora ha sido modificada!"),
          Text(
            "Nueva",
          ),
          TimeWidget(
            inOrderOfArrival: _inOrderOfArrival,
            time: _appointmentAt,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 30, right: 30),
            child: OutlinedButton(
              onPressed: () {
                Routes.backHome(context);
              },
              child: Text("Ok"),
            ),
          )
        ],
      ),
    );
  }
}
