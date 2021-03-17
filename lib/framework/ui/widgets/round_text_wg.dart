import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundText extends StatelessWidget {
  String text;
  double width;
  bool enabled;

  RoundText(String text, {double width = 80, bool enabled = true}) {
    this.text = text;
    this.width = width;
    this.enabled = enabled;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: enabled
            ? Theme.of(context).accentColor
            : Theme.of(context).disabledColor,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: EdgeInsets.only(left: 4, right: 4),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
