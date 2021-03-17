import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_docere/domain/extensions.dart';

class TimeWidget extends StatelessWidget {
  final DateTime time;
  final bool inOrderOfArrival;

  TimeWidget({this.time, this.inOrderOfArrival});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: BoxDecoration(
        color: Colors.lightGreen[400],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.watch_later_outlined,
            color: Colors.white,
          ),
          Expanded(
            child: Text(
              inOrderOfArrival
                  ? "Oden de llegada"
                  : DateTimeHelper.format(time, pattern: "hh:mm a"),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
