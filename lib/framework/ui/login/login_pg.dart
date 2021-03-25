import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_docere/domain/models/session.dart';
import 'package:project_docere/domain/routers/routes.dart';
import 'package:project_docere/injection_container.dart';

class LoginPage extends StatelessWidget {
  static String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Container(
              height: 100,
              width: 100,
              child: Image.network(
                  "https://media.istockphoto.com/vectors/caduceus-medical-symbol-vector-id471629610?k=6&m=471629610&s=612x612&w=0&h=59MddMN1yIVPhleIBIhrhKEC74jCxI4CLTg6mGAPlqU="),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 30, right: 30),
              child: ElevatedButton(
                  onPressed: () {
                    currentTestSession = SecretarySessionTmp();
                    Routes.goHome(context);
                  },
                  child: Text("Secretaria")),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 30, right: 30, top: 20),
              child: ElevatedButton(
                  onPressed: () {
                    currentTestSession = PatientSessionTmp();
                    Routes.goHome(context);
                  },
                  child: Text("Paciente")),
            ),
            Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
