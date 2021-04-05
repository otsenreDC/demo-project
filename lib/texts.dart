import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/colors.dart';

class MedAppTextStyle {
  static TextStyle title() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
    );
  }

  static TextStyle header1() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: MedAppColors.text,
      fontSize: 20,
    );
  }

  static TextStyle header2() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: MedAppColors.text,
      fontSize: 18,
    );
  }

  static TextStyle header3() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: MedAppColors.text,
      fontSize: 16,
    );
  }

  static TextStyle body() {
    return TextStyle(
      fontSize: 14,
      color: MedAppColors.text,
    );
  }

  static TextStyle label() {
    return TextStyle(
      fontSize: 14,
      color: MedAppColors.text,
    );
  }

  static TextStyle labelSmall() {
    return TextStyle(
      fontSize: 14,
      color: MedAppColors.text,
    );
  }
}
