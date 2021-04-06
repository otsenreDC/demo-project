import 'package:flutter/material.dart';

import '../../../colors.dart';

InputDecoration inputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    fillColor: MedAppColors.black196,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MedAppColors.blue),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
