import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_docere/domain/extensions.dart';

class DayWidget extends StatelessWidget {
  final DateTime day;

  DayWidget({@required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(DateTimeHelper.format(day, pattern: DATE_FORMAT_EXPRESSIVE)),
          Icon(Icons.calendar_today)
        ],
      ),
    );
  }
}
