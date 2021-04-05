import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/colors.dart';
import 'package:project_docere/domain/models/patient.dart';
import 'package:project_docere/domain/view_models/patients/patient_info_vm.dart';

InputDecoration _inputDecoration(String hint) {
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
              decoration: _inputDecoration("Nombre"),
              onChanged: (text) {
                viewModel.name = text;
              },
            ),
          ),
          _inputContainer(
            TextFormField(
              maxLines: 1,
              decoration: _inputDecoration("Apellidos"),
              onChanged: (text) {
                viewModel.lastName = text;
              },
            ),
          ),
          _inputContainer(
            TextFormField(
              maxLines: 1,
              decoration: _inputDecoration("Teléfono"),
              onChanged: (text) {
                viewModel.phone = text;
              },
            ),
          ),
          _inputContainer(
            TextFormField(
              maxLines: 1,
              decoration: _inputDecoration("Correo electrónico"),
              onChanged: (text) {
                viewModel.email = text;
              },
            ),
          ),
          _inputContainer(
            TextFormField(
              maxLines: 1,
              decoration: _inputDecoration("Cédula"),
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
