import 'package:flutter/material.dart';
import 'package:project_docere/texts.dart';

import 'colors.dart';

class MedAppStyles {
  static ButtonStyle lighBlueButtonStyle = ElevatedButton.styleFrom(
    textStyle: MedAppTextStyle.header3(),
    primary: MedAppColors.lighterBlue, // background
    onPrimary: MedAppColors.lightBlue,
    shadowColor: Colors.transparent,
  );
}
