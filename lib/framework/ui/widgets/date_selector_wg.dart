import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:project_docere/colors.dart';
import 'package:project_docere/domain/extensions.dart';
import 'package:project_docere/texts.dart';

class DateSelector extends StatefulWidget {
  final Function(DateTime) onDateChanged;
  final DateTime date;

  DateSelector({
    @required this.date,
    @required this.onDateChanged,
  });

  @override
  State createState() => _DateSelectorState(
        date: date,
        onDateChanged: this.onDateChanged,
      );
}

class _DateSelectorState extends State<DateSelector> {
  final Function(DateTime) onDateChanged;
  DateTime date;

  _DateSelectorState({@required this.onDateChanged, @required this.date});

  final DateFormat formatter = DateFormat(DATE_FORMAT_EXPRESSIVE);

  String _dateString(DateTime dateTime) {
    if (dateTime.isToday()) return "HOY";
    if (dateTime.isYesterday()) return "AYER";
    if (dateTime.isTomorrow()) return "MAÑANA";
    return formatter.format(date).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left),
          iconSize: 20,
          color: MedAppColors.black200,
          onPressed: () {
            setState(() {
              date = date.subtract(Duration(days: 1));
              onDateChanged(date);
            });
          },
        ),
        Expanded(
          child: Center(
            child: Text(
              _dateString(date),
              style: MedAppTextStyle.body(),
            ),
          ),
        ),
        IconButton(
          iconSize: 20,
          icon: Icon(Icons.chevron_right),
          color: MedAppColors.black200,
          onPressed: () {
            setState(() {
              date = date.add(Duration(days: 1));
              onDateChanged(date);
            });
          },
        )
      ],
    );
  }
}
