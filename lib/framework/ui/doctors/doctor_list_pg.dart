import 'package:flutter/cupertino.dart';

class DoctorListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) => Text("DOCTOR $index"),
    );
  }
}
