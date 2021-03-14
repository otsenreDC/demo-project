import 'package:flutter/widgets.dart';
import 'package:project_docere/framework/ui/home/home_pg.dart';

class Routes {
  static backHome(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(HomePage.routeName));
  }
}
