import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/domain/extensions.dart';
import 'package:project_docere/domain/models/center_info.dart';
import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/view_models/appointments/create_appointment_vm.dart';
import 'package:project_docere/framework/ui/create_appointment/input_patient_info.dart';
import 'package:project_docere/framework/ui/widgets/date_selector_wg.dart';
import 'package:project_docere/framework/ui/widgets/doctor_app_bar.dart';
import 'package:project_docere/framework/ui/widgets/hours_wg.dart';
import 'package:project_docere/framework/ui/widgets/simple_center_card_wg.dart';
import 'package:project_docere/injection_container.dart';
import 'package:provider/provider.dart';

import 'confirm_appointment_pg.dart';

class CreateAppointmentArguments {
  final Doctor doctor;

  CreateAppointmentArguments({@required this.doctor});
}

class CreateAppointmentPage extends StatelessWidget {
  static final String routeName = "/createAppointment";

  void _navigateToConfirmationPage(
    BuildContext context,
    CreateAppointmentViewModel viewModel,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmAppointmentPage(
            patient: viewModel.getPatient,
            doctor: viewModel.getDoctor,
            centerInfo: viewModel.getSelectedCenter,
            day: viewModel.getSelectedDate,
            daySlot: viewModel.getSelectedHour,
            dateTime: viewModel.getSelectedDateTime),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CreateAppointmentArguments _args =
        ModalRoute.of(context).settings.arguments;
    final Doctor _doctor = _args.doctor;

    return ChangeNotifierProvider(
      create: (_) {
        final CreateAppointmentViewModel viewModel =
            sl<CreateAppointmentViewModel>();
        viewModel.start(_doctor);
        return viewModel;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: DoctorAppBar(
            fullName: "${_doctor.name} ${_doctor.lastName}",
            specialty: _doctor.specialty,
          ),
        ),
        body: Consumer<CreateAppointmentViewModel>(
          builder: (_, viewModel, __) {
            return viewModel.needPatientInfo
                ? PatientInfoForm(
                    (patient) {
                      viewModel.setPatient = patient;
                    },
                  )
                : Container(
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Centros Médicos",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.local_hospital_outlined,
                              size: 15,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: _doctor.centerInfo.map((CenterInfo center) {
                            return SimpleCenterCard(
                              name: center.name,
                              address: center.address,
                              selected: viewModel.centerIsSelected(center),
                              onTap: () {
                                viewModel.setSelectedCenter = center;
                              },
                            );
                          }).toList(),
                        ),
                        HourSection(
                          key: UniqueKey(),
                          calendarStatus: viewModel.getCalendarStatus,
                          onSlotSelected: (day, slot, dateTime) {
                            viewModel.setSelectedDate = day;
                            viewModel.setSelectedHour = slot;
                            viewModel.setSelectedDateTime = dateTime;
                            _navigateToConfirmationPage(context, viewModel);
                          },
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class HourSection extends StatefulWidget {
  final CalendarStatus calendarStatus;
  final Function(Day, DaySlot, DateTime) onSlotSelected;

  HourSection({
    Key key,
    @required this.calendarStatus,
    @required this.onSlotSelected,
  }) : super(key: key);

  @override
  _HourSectionState createState() {
    return _HourSectionState(
      calendarStatus: calendarStatus,
      onSlotSelected: onSlotSelected,
    );
  }
}

class _HourSectionState extends State<HourSection> {
  CalendarStatus calendarStatus;
  Function(Day, DaySlot, DateTime) onSlotSelected;

  Day _selectedDay;
  DaySlot _selectedHour;
  DateTime _selectedDateTime = DateTime.now();

  _HourSectionState({
    @required this.calendarStatus,
    @required this.onSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (calendarStatus.error) {
      return Center(child: Text("Error"));
    } else if (calendarStatus.loading) {
      return Center(
          child: CircularProgressIndicator(
        value: null,
      ));
    } else if (calendarStatus.data == null) {
      return Center(child: Text("Select a center"));
    } else if (calendarStatus.data != null) {
      return Container(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Horas disponibles",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.query_builder,
                  size: 15,
                ),
              ],
            ),
            DateSelector(
              date: DateTime.now(),
              onDateChanged: (date) {
                setState(() {
                  _selectedHour = null;
                  _selectedDay = calendarStatus.data.days
                      .firstWhere((element) => element.id == date.dayOfYear,
                          // date.difference(DateTime(2021, 1, 1, 0, 0)).inDays,
                          orElse: () => null);
                  _selectedDateTime = date;
                });
              },
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50),
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                    primary: _selectedHour?.inOrderOfArrival == true
                        ? Colors.white
                        : Colors.blue[800],
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                    backgroundColor: _selectedHour?.inOrderOfArrival == true
                        ? Theme.of(context).accentColor
                        : Colors.lightBlue[100]),
                onPressed: () {
                  setState(() {
                    _selectedHour = DaySlot.inOrderOfArrival();
                    onSlotSelected(
                        _selectedDay, _selectedHour, _selectedDateTime);
                  });
                },
                child: Text("Orden de llegada"),
              ),
            ),
            Container(
              child: HoursWidget(
                day: _selectedDay,
                selectedHour: _selectedHour,
                onTap: (value) {
                  setState(() {
                    _selectedHour = value;
                    onSlotSelected(
                        _selectedDay, _selectedHour, _selectedDateTime);
                  });
                },
              ),
            )
          ],
        ),
      );
    } else {
      return Text("Error desconocido");
    }
  }
}
