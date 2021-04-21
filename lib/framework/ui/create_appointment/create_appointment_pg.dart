import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/domain/extensions.dart';
import 'package:project_docere/domain/models/center_info.dart';
import 'package:project_docere/domain/models/day.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/view_models/appointments/create_appointment_vm.dart';
import 'package:project_docere/framework/ui/widgets/date_selector_wg.dart';
import 'package:project_docere/framework/ui/widgets/doctor_item.dart';
import 'package:project_docere/framework/ui/widgets/hours_wg.dart';
import 'package:project_docere/framework/ui/widgets/simple_center_card_wg.dart';
import 'package:project_docere/injection_container.dart';
import 'package:project_docere/texts.dart';
import 'package:provider/provider.dart';

import '../../../colors.dart';
import 'confirm_appointment_pg.dart';
import 'input_patient_info.dart';

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
        viewModel.start(_doctor, () {
          _navigateToConfirmationPage(context, viewModel);
        });
        return viewModel;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Creando Cita",
            style: MedAppTextStyle.title(),
          ),
        ),
        body: Consumer<CreateAppointmentViewModel>(
          builder: (_, viewModel, __) {
            if (viewModel.showPatientInfo) {
              return PatientInfoForm(
                (patient) {
                  viewModel.setPatient = patient;
                },
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    DoctorItem(
                      viewModel.getDoctor.fullName,
                      viewModel.getDoctor.specialty,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    _TimeSelection(viewModel),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _TimeSelection extends StatelessWidget {
  final CreateAppointmentViewModel _viewModel;

  _TimeSelection(this._viewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 30, right: 30),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            children: [
              Text(
                "Centros Médicos",
                style: MedAppTextStyle.header2(),
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
            children: _viewModel.getDoctor.centerInfo.map((CenterInfo center) {
              return SimpleCenterCard(
                name: center.name,
                address: center.address,
                selected: _viewModel.centerIsSelected(center),
                onTap: () {
                  _viewModel.setSelectedCenter = center;
                },
              );
            }).toList(),
          ),
          SizedBox(
            height: 30,
          ),
          HourSection(
            key: UniqueKey(),
            calendarStatus: _viewModel.getCalendarStatus,
            onSlotSelected: (day, slot, dateTime) {
              _viewModel.confirmInspection(day, slot, dateTime);
            },
          )
        ],
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
      return Container(
          width: double.infinity,
          height: 200,
          child: Center(
              child: Text(
            "Seleccione un centro",
            style: MedAppTextStyle.body(),
          )));
    } else if (calendarStatus.data != null) {
      return Container(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Horas disponibles",
                  style: MedAppTextStyle.header2(),
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
                  _selectedDay = calendarStatus.data.days.firstWhere(
                      (element) => element.id == date.dayOfYear,
                      orElse: () => null);
                  _selectedDateTime = date;
                });
              },
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: MedAppTextStyle.header3(),
                  primary: MedAppColors.lighterBlue, // background
                  onPrimary: MedAppColors.lightBlue,
                  shadowColor: Colors.transparent,
                ),
                onPressed: _selectedDay?.isEnabled == true
                    ? () {
                        setState(() {
                          _selectedHour = DaySlot.inOrderOfArrival();
                          onSlotSelected(
                              _selectedDay, _selectedHour, _selectedDateTime);
                        });
                      }
                    : null,
                child: Text("Orden de llegada"),
              ),
            ),
            SizedBox(
              height: 25,
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
            ),
            SizedBox(height: 30,),
          ],
        ),
      );
    } else {
      return Text("Error desconocido");
    }
  }
}
