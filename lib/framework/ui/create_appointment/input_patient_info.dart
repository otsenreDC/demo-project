import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:project_docere/domain/models/patient.dart';
import 'package:project_docere/domain/view_models/patients/patient_info_vm.dart';
import 'package:project_docere/framework/ui/widgets/text_input_decoration.dart';

Container _inputContainer(Widget child) {
  return Container(
    width: double.infinity,
    child: child,
    margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
  );
}

class PatientInfoForm extends StatelessWidget {
  final PatientInfoViewModel viewModel = PatientInfoViewModel();
  final Function(Patient) _onPatientCompleted;

  PatientInfoForm(this._onPatientCompleted);

  void _displaySnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Datos incompletos.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _inputContainer(
            TextField(
              maxLines: 1,
              decoration: inputDecoration("Nombre"),
              onChanged: (text) {
                viewModel.name = text;
              },
            ),
          ),
          _inputContainer(
            TextFormField(
              maxLines: 1,
              decoration: inputDecoration("Apellidos"),
              onChanged: (text) {
                viewModel.lastName = text;
              },
            ),
          ),
          _inputContainer(
            TextFormField(
              maxLines: 1,
              decoration: inputDecoration("Teléfono"),
              inputFormatters: <TextInputFormatter>[
                MaskedInputFormater("000-000-0000"),
              ],
              onChanged: (text) {
                viewModel.phone = text;
              },
            ),
          ),
          _inputContainer(
            TextFormField(
              maxLines: 1,
              decoration: inputDecoration("Correo electrónico"),
              onChanged: (text) {
                viewModel.email = text;
              },
            ),
          ),
          _inputContainer(
            TextFormField(
              maxLines: 1,
              decoration: inputDecoration("Cédula"),
              onChanged: (text) {
                viewModel.personalId = text;
              },
            ),
          ),
          _inputContainer(
            ElevatedButton(
              onPressed: () {
                if (viewModel.isComplete) {
                  _onPatientCompleted(viewModel.getDetails());
                } else {
                  _displaySnackbar(context);
                }
              },
              child: Text("Siguiente"),
            ),
          )
        ],
      ),
    );
  }
}
