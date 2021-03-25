import 'package:flutter/widgets.dart';
import 'package:project_docere/framework/ui/appointments/secretary/appointment_authorization_wg.dart';
import 'package:project_docere/framework/ui/home/home_pg.dart';
import 'package:project_docere/framework/ui/login/login_pg.dart';

class Routes {
  static popToLogin(BuildContext context) {
    Navigator.popAndPushNamed(context, LoginPage.routeName);
  }

  static backHome(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(HomePage.routeName));
  }

  static goHome(BuildContext context) {
    Navigator.popAndPushNamed(context, HomePage.routeName);
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }

  static navigateToAppointmentAuthorization(
    BuildContext context,
    String routeName,
    AppointmentAuthorizationArguments arguments,
  ) {
    Navigator.pushNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }
}
