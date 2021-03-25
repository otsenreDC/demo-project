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
            Container(
              height: 100,
              width: 100,
              child: Image.network(
                  "https://is5-ssl.mzstatic.com/image/thumb/Purple111/v4/c1/c0/fc/c1c0fc10-f049-9c7f-f38d-9fd076b0f846/source/256x256bb.jpg"),
            ),
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
              margin: EdgeInsets.only(left: 30, right: 30),
              child: ElevatedButton(
                  onPressed: () {
                    currentTestSession = PatientSessionTmp();
                    Routes.goHome(context);
                  },
                  child: Text("Paciente")),
            )
          ],
        ),
      ),
    );
  }
}
