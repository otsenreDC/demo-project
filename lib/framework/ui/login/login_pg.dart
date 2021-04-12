import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_docere/colors.dart';
import 'package:project_docere/domain/models/ui_state.dart';
import 'package:project_docere/domain/view_models/login/login_vm.dart';
import 'package:project_docere/framework/ui/widgets/error_wg.dart';
import 'package:project_docere/framework/ui/widgets/loadgin_wg.dart';
import 'package:project_docere/framework/ui/widgets/text_input_decoration.dart';
import 'package:project_docere/framework/ui/widgets/vertical_spacer.dart';
import 'package:project_docere/injection_container.dart';
import 'package:project_docere/texts.dart';
import 'package:provider/provider.dart';

Container _inputContainer(Widget child) {
  return Container(
    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
    child: child,
  );
}

class LoginPage extends StatelessWidget {
  static String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext buildContext) {
        final viewModel = sl<LoginViewModel>(param1: buildContext);
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => {viewModel.validateSession()},
        );
        return viewModel;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<LoginViewModel>(builder: (_, viewModel, __) {
          final uiState = viewModel.getUIState;

          if (uiState is UIShowData) {
            return _LoginScreen(
              viewModel,
              errorMessage: "",
            );
          }
          if (uiState is UILoading) {
            return Loading();
          }
          if (uiState is UIError) {
            return _LoginScreen(
              viewModel,
              errorMessage: uiState.message,
            );
          }
          return Error(message: "Error cargando página");
        }),
      ),
    );
  }
}

class _LoginScreen extends StatelessWidget {
  final LoginViewModel _viewModel;
  final String errorMessage;

  const _LoginScreen(this._viewModel, {this.errorMessage = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            // padding: EdgeInsets.only(left: 30, right: 30),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("images/login_img.jpeg"),
              _inputContainer(TextFormField(
                decoration: inputDecoration("Correo electrónico"),
                onChanged: (String value) {
                  _viewModel.setEmail = value;
                },
              )),
              _inputContainer(TextFormField(
                obscureText: true,
                onChanged: (String value) {
                  _viewModel.setPassword = value;
                },
                autocorrect: false,
                enableSuggestions: false,
                decoration: inputDecoration("Contraseña"),
              )),
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: MedAppTextStyle.body().copyWith(
                  color: MedAppColors.red,
                ),
              ),
              VerticalSpacer(30),
              ElevatedButton(
                  onPressed: () {
                    _viewModel.signIn();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Text("Inicia sesión")),
              VerticalSpacer(10),
              TextButton(onPressed: () {}, child: Text("Olvidó su contraseña")),
              VerticalSpacer(20),
              /*Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: MedAppColors.blue,
                      height: 1,
                      endIndent: 10,
                    ),
                  ),
                  Text("o"),
                  Expanded(
                      child: Divider(
                    indent: 10,
                    color: MedAppColors.blue,
                  ))
                ],
              ),
              VerticalSpacer(10),
              Text(
                "Inicia con".toUpperCase(),
                style: MedAppTextStyle.label().copyWith(
                  color: MedAppColors.black180,
                ),
                textAlign: TextAlign.center,
              ),
              VerticalSpacer(10),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      color: MedAppColors.black120,
                      icon: Icon(Icons.ac_unit_outlined),
                      onPressed: () {}),
                  IconButton(
                      color: MedAppColors.blue,
                      icon: Icon(Icons.face),
                      onPressed: () {}),
                  IconButton(
                      color: MedAppColors.red,
                      icon: Icon(Icons.account_box),
                      onPressed: () {}),
                ],
              ),
               */
              /*
              VerticalSpacer(100),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.cyan),
                  onPressed: () {
                    currentSession = SecretarySessionTmp();
                    Routes.goHome(context);
                  },
                  child: Text("Secretaria")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.teal),
                  onPressed: () {
                    currentSession = PatientSessionTmp();
                    Routes.goHome(context);
                  },
                  child: Text("Paciente")),
               */
            ],
          ),
        ),
      ),
    );
  }
}
