import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/colors.dart';
import 'package:project_docere/domain/extensions.dart';
import 'package:project_docere/domain/models/profile.dart';
import 'package:project_docere/domain/view_models/profile/profile_vm.dart';
import 'package:project_docere/framework/ui/widgets/phone_tile.dart';
import 'package:project_docere/framework/ui/widgets/text_tile.dart';
import 'package:provider/provider.dart';

import '../../../injection_container.dart';

class ProfilePage extends StatelessWidget {
  static final String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    Future<bool> _willPop(ProfileViewModel viewModel) async {
      if (viewModel.getShowAccountDetails) {
        viewModel.showOptions();
        return false;
      } else {
        return true;
      }
    }

    return ChangeNotifierProvider<ProfileViewModel>(
      create: (_) {
        return sl();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Perfil"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Consumer<ProfileViewModel>(
          builder: (_, viewModel, __) {
            if (viewModel.getShowAccountDetails) {
              return WillPopScope(
                child: AccountInformation(viewModel.getProfile),
                onWillPop: () => _willPop(viewModel),
              );
            } else {
              return _OptionsList(viewModel);
            }
          },
        ),
      ),
    );
  }
}

class AccountInformation extends StatelessWidget {
  final Profile _profile;

  const AccountInformation(this._profile);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            maxRadius: 50,
            minRadius: 35,
            backgroundImage: NetworkImage(
                "https://image.flaticon.com/icons/png/512/1430/1430453.png"),
          ),
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 8),
            child: Divider(
              thickness: 1,
              color: Colors.grey[400],
            ),
          ),
          _OptionText(
            "Nombre",
            marging: EdgeInsets.fromLTRB(30, 10, 30, 0),
          ),
          TextTile(_profile?.fullName),
          _OptionText(
            "Cédula",
            marging: EdgeInsets.fromLTRB(30, 10, 30, 0),
          ),
          TextTile(_profile?.personalId),
          _OptionText(
            "Fecha de nacimiento",
            marging: EdgeInsets.fromLTRB(30, 10, 30, 0),
          ),
          BirthdayTile(_profile?.birthday),
          _OptionText(
            "Teléfono",
            marging: EdgeInsets.fromLTRB(30, 10, 30, 0),
          ),
          PhoneTile("888 - 555 - 1234")
        ],
      ),
    );
  }
}

class _OptionText extends StatelessWidget {
  final String _text;
  final EdgeInsets marging;

  const _OptionText(
    this._text, {
    this.marging = const EdgeInsets.only(
      left: 30,
      right: 30,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: marging,
      child: Text(
        _text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _OptionsList extends StatelessWidget {
  final ProfileViewModel _viewModel;

  const _OptionsList(this._viewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 40,
          ),
          TextTile(
            "Información de la cuenta",
            leadingIcon: Icon(Icons.account_circle_outlined),
            onSelected: _viewModel.showAccountDetails,
            trailingIcon: Icon(Icons.arrow_forward),
          ),
          SizedBox(height: 10),
          TextTile(
            "Cerrar sesión",
            leadingIcon: Icon(Icons.logout),
            trailingIcon: Icon(Icons.arrow_forward),
            onSelected: () {
              showAlertDialog(
                  context, () => {_viewModel.signOut(context)}, () => {});
            },
          ),
        ],
      ),
    );
  }
}

class BirthdayTile extends StatelessWidget {
  final DateTime _birthday;
  final Function onSelected;
  final Icon leadingIcon;
  final Icon trailingIcon;

  const BirthdayTile(
    this._birthday, {
    this.onSelected,
    this.leadingIcon,
    this.trailingIcon,
  });

  String _getDay() {
    if (_birthday != null) {
      return DateTimeHelper.format(_birthday, pattern: "dd");
    } else {
      return "DD";
    }
  }

  String _getMonth() {
    if (_birthday != null) {
      return DateTimeHelper.format(_birthday, pattern: "MM");
    } else {
      return "MM";
    }
  }

  String _getYear() {
    if (_birthday != null) {
      return DateTimeHelper.format(_birthday, pattern: "yyyy");
    } else {
      return "YYYY";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      decoration: BoxDecoration(
        color: MedAppColors.black247,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ListTile(
        onTap: onSelected,
        title: Row(
          children: [
            Expanded(
                child: Text(
              _getDay(),
              textAlign: TextAlign.center,
            )),
            Container(
              width: 1,
              height: 40,
              color: Colors.grey[400],
            ),
            Expanded(child: Text(_getMonth(), textAlign: TextAlign.center)),
            Container(
              width: 1,
              height: 40,
              color: Colors.grey[400],
            ),
            Expanded(child: Text(_getYear(), textAlign: TextAlign.center))
          ],
        ),
        leading: leadingIcon,
        trailing: trailingIcon,
      ),
    );
  }
}

showAlertDialog(
  BuildContext context,
  Function() agree,
  Function() disagree,
) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.of(context).pop();
      disagree();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Cerrar sesión"),
    onPressed: () {
      Navigator.of(context).pop();
      agree();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Advertencia"),
    content: Text("¿Está seguro que quiere cerrar la sesión?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
