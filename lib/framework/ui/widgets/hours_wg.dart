import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_docere/domain/extensions.dart';
import 'package:project_docere/domain/models/day.dart';

class HoursWidget extends StatelessWidget {
  final Day day;
  final DaySlot selectedHour;
  final Function(DaySlot) onTap;

  HoursWidget({@required this.day, this.selectedHour, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (day == null || day.daySlots == null || day.daySlots.isEmpty == true) {
      return Container(
        margin: EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        child: Text("Día no configurado."),
      );
    }
    if (day.holiday) {
      return Container(
        margin: EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        child: Text("Día feriado nacional."),
      );
    }
    if (!day.workday) {
      return Container(
        margin: EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        child: Text("Día no laborable."),
      );
    } else if (day?.daySlots?.isEmpty == true) {
      return Container(
        margin: EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        child: Text("No hay horario disponible."),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: day.daySlots.map((value) {
          return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: selectedHour == value
                      ? Theme.of(context).accentColor
                      : Colors.grey),
              onPressed: value.taken
                  ? null
                  : () {
                      onTap(value);
                    },
              child: Text(
                "${DateTimeHelper.format(value?.start?.toDate(), pattern: DATE_FORMAT_TIME)}",
              ));
        }).toList(),
      );
    }
  }
}
