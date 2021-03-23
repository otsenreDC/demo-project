import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/domain/models/insurance.dart';
import 'package:project_docere/domain/routers/routes.dart';

Container _inputContainer(Widget child,
    {double left = 30,
    double top = 10,
    double right = 30,
    double bottom = 10}) {
  return Container(
    width: double.infinity,
    child: child,
    margin: EdgeInsets.fromLTRB(left, top, right, bottom),
  );
}

class AppointmentAuthorizationArguments {
  final Function(Insurance) onProviderSelected;

  AppointmentAuthorizationArguments(this.onProviderSelected);
}

class AppointmentAuthorizationPage extends StatefulWidget {
  static String routName = "appointment/insurance_selector";

  @override
  _AppointmentAuthorizationPageState createState() =>
      _AppointmentAuthorizationPageState();
}

class _AppointmentAuthorizationPageState
    extends State<AppointmentAuthorizationPage> {
  InsuranceProvider _selectedProvider;
  String _authorizationNumber;

  void _displaySnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Datos incompletos.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppointmentAuthorizationArguments arguments =
        (ModalRoute.of(context).settings.arguments);
    final Function(Insurance) _onProvidedSelected =
        arguments.onProviderSelected;

    return Scaffold(
      appBar: AppBar(),
      body: _selectedProvider == null
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Text("Elige el seguro de preferencia"),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: OutlinedButton(
                          onPressed: () {}, child: Text("Paciente privado"))),
                  Divider(
                    color: Colors.black54,
                  ),
                  GridView.count(
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(16),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    shrinkWrap: true,
                    children: InsuranceProvider.values
                        .map((provider) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedProvider = provider;
                                });
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image(
                                    image: AssetImage(provider.asset()),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            )
          : Column(
              children: [
                Text("Introduzca el número de autorización"),
                _inputContainer(TextField(
                  decoration: InputDecoration(
                    hintText: "Autorización",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (newValue) {
                    _authorizationNumber = newValue;
                  },
                )),
                _inputContainer(
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedProvider != null &&
                          _authorizationNumber?.isNotEmpty == true) {
                        _onProvidedSelected(
                          Insurance(
                            _selectedProvider,
                            authorizationNumber: _authorizationNumber,
                          ),
                        );
                        Routes.pop(context);
                      } else {
                        _displaySnackbar(context);
                      }
                    },
                    child: Text("Aceptar"),
                  ),
                  top: 8,
                  bottom: 0,
                ),
                _inputContainer(
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _authorizationNumber = null;
                        _selectedProvider = null;
                      });
                    },
                    child: Text("Volver a Proveedores"),
                  ),
                  top: 0,
                  bottom: 8,
                ),
              ],
            ),
    );
  }
}
