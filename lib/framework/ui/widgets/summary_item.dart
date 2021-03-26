import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../texts.dart';

class SummaryItem extends StatelessWidget {
  final String _label;
  final int _value;
  final Color labelTextColor;
  final Color valueTextColor;

  SummaryItem(
    this._label,
    this._value, {
    this.valueTextColor = Colors.white,
    this.labelTextColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            _label,
            style: MedAppTextStyle.label().copyWith(
              color: labelTextColor,
            ),
          ),
          Text(
            "$_value",
            style: MedAppTextStyle.body().copyWith(
              fontWeight: FontWeight.bold,
              color: valueTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
