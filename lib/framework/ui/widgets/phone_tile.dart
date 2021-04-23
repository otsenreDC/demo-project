import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../colors.dart';

class PhoneTile extends StatelessWidget {
  final String _title;
  final Function onSelected;
  final Icon leadingIcon;
  final Icon trailingIcon;

  PhoneTile(
    this._title, {
    this.onSelected,
    this.leadingIcon,
    this.trailingIcon,
  });

  String _getPhoneSection(int section) {
    if (_title == null) return "";

    final _split = _title.split('-');

    if (_split.length > section) {
      return _split[section];
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        color: MedAppColors.black196,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ListTile(
        onTap: onSelected,
        title: Row(
          children: [
            Expanded(
                child: Text(
              _getPhoneSection(0),
              textAlign: TextAlign.center,
            )),
            Container(
              width: 15,
              height: 1,
              color: Colors.grey[400],
            ),
            Expanded(
                child: Text(
              _getPhoneSection(1),
              textAlign: TextAlign.center,
            )),
            Container(
              width: 15,
              height: 1,
              color: Colors.grey[400],
            ),
            Expanded(
                child: Text(
              _getPhoneSection(2),
              textAlign: TextAlign.center,
            ))
          ],
        ),
        leading: leadingIcon,
        trailing: trailingIcon,
      ),
    );
  }
}