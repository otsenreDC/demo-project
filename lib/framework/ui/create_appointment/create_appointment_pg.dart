import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/framework/ui/widgets/doctor_app_bar.dart';

class CreateAppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: PreferredSize(
          child: DoctorAppBar(),
        ),
      );
}
