import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../colors.dart';
import '../../../texts.dart';

class DoctorItem extends StatelessWidget {
  final String _name;
  final String _specialty;
  final double width;

  DoctorItem(this._name, this._specialty, {this.width = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 4, 30, 4),
      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: MedAppColors.lighterBlue,
      ),
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: MedAppColors.lightBlue,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          // width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _name,
                    style: MedAppTextStyle.label().copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _specialty,
                    style:
                        MedAppTextStyle.label().copyWith(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                width: 8,
              ),
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                  "https://cdn2.iconfinder.com/data/icons/avatar-business-people-set-one/128/avatar-25-512.png",
                ),
              ),
            ],
          )),
    );
  }
}
