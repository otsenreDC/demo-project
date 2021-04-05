import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/colors.dart';

class TextTile extends StatelessWidget {
  final String _title;
  final Function onSelected;
  final Icon leadingIcon;
  final Icon trailingIcon;

  const TextTile(
    this._title, {
    this.onSelected,
    this.leadingIcon,
    this.trailingIcon,
  });

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
        title: Text(_title),
        leading: leadingIcon,
        trailing: trailingIcon,
      ),
    );
  }
}
