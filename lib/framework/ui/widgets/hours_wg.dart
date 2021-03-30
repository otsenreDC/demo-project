import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_docere/domain/extensions.dart';
import 'package:project_docere/domain/models/day.dart';

import '../../../texts.dart';

class HoursWidget extends StatelessWidget {
  final Day day;
  final DaySlot selectedHour;
  final Function(DaySlot) onTap;

  HoursWidget({@required this.day, this.selectedHour, @required this.onTap})
      : super(key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    if (day == null || day.daySlots == null || day.daySlots.isEmpty == true) {
      return Container(
        margin: EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        child: Text(
          "Día no configurado.",
          style: MedAppTextStyle.body(),
        ),
      );
    }
    if (day.holiday) {
      return Container(
        margin: EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        child: Text(
          "Día feriado nacional.",
          style: MedAppTextStyle.body(),
        ),
      );
    }
    if (!day.workday) {
      return Container(
        margin: EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        child: Text(
          "Día no laborable.",
          style: MedAppTextStyle.body(),
        ),
      );
    } else if (day?.daySlots?.isEmpty == true) {
      return Container(
        margin: EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        child: Text(
          "No hay horario disponible.",
          style: MedAppTextStyle.body(),
        ),
      );
    } else {
      return GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        primary: false,
        childAspectRatio: 100 / 40,
        crossAxisSpacing: 8,
        mainAxisSpacing: 10,
        children: day.daySlots.map((value) {
          return ElevatedButton(
              onPressed: value.taken
                  ? null
                  : () {
                      onTap(value);
                    },
              child: Text(
                "${DateTimeHelper.format(
                  value?.start?.toDate(),
                  pattern: DATE_FORMAT_TIME,
                )}",
              ));
        }).toList(),
      );
      /*return Column(
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
                "${DateTimeHelper.format(
                  value?.start?.toDate(),
                  pattern: DATE_FORMAT_TIME,
                )}",
              ));
        }).toList(),
      );*/
    }
  }
}
