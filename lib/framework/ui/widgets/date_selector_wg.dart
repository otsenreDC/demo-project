import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:project_docere/domain/extensions.dart';

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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              setState(() {
                date = date.subtract(Duration(days: 1));
                onDateChanged(date);
              });
            },
          ),
        ),
        Expanded(
          child: Center(child: Text(formatter.format(date))),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                date = date.add(Duration(days: 1));
                onDateChanged(date);
              });
            },
          ),
        )
      ],
    );
  }
}
