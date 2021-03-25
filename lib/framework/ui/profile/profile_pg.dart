import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_docere/domain/view_models/profile/profile_vm.dart';
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
      child: Consumer<ProfileViewModel>(
        builder: (_, viewModel, __) {
          if (viewModel.getShowAccountDetails) {
            return WillPopScope(
              child: AccountInformation(),
              onWillPop: () => _willPop(viewModel),
            );
          } else {
            return _OptionsList(viewModel);
          }
        },
      ),
    );
  }
}

class AccountInformation extends StatelessWidget {
  const AccountInformation({
    Key key,
  }) : super(key: key);

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
          _TextTile("Susuna Robles"),
          _OptionText(
            "Cédula",
            marging: EdgeInsets.fromLTRB(30, 10, 30, 0),
          ),
          _TextTile("000-1111111-2"),
          _OptionText(
            "Fecha de nacimiento",
            marging: EdgeInsets.fromLTRB(30, 10, 30, 0),
          ),
          _BirthdayTile("00 | 00 | 0000"),
          _OptionText(
            "Teléfono",
            marging: EdgeInsets.fromLTRB(30, 10, 30, 0),
          ),
          _PhoneTile("888 - 555 - 1234")
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
          _TextTile(
            "Información de la cuenta",
            leadingIcon: Icon(Icons.account_circle_outlined),
            onSelected: _viewModel.showAccountDetails,
            trailingIcon: Icon(Icons.arrow_forward),
          ),
          _TextTile(
            "Cerrar sesión",
            leadingIcon: Icon(Icons.logout),
            trailingIcon: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}

class _TextTile extends StatelessWidget {
  final String _title;
  final Function onSelected;
  final Icon leadingIcon;
  final Icon trailingIcon;

  const _TextTile(
    this._title, {
    this.onSelected,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ListTile(
        onTap: onSelected,
        title: Text(_title),
        leading: leadingIcon,
        trailing: trailingIcon,
      ),
    );
  }
}

class _BirthdayTile extends StatelessWidget {
  final String _title;
  final Function onSelected;
  final Icon leadingIcon;
  final Icon trailingIcon;

  const _BirthdayTile(
    this._title, {
    this.onSelected,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
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
              "00",
              textAlign: TextAlign.center,
            )),
            Container(
              width: 2,
              height: 40,
              color: Colors.grey[500],
            ),
            Expanded(child: Text("02", textAlign: TextAlign.center)),
            Container(
              width: 2,
              height: 40,
              color: Colors.grey[500],
            ),
            Expanded(child: Text("2020", textAlign: TextAlign.center))
          ],
        ),
        leading: leadingIcon,
        trailing: trailingIcon,
      ),
    );
  }
}

class _PhoneTile extends StatelessWidget {
  final String _title;
  final Function onSelected;
  final Icon leadingIcon;
  final Icon trailingIcon;

  const _PhoneTile(
    this._title, {
    this.onSelected,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
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
              "849",
              textAlign: TextAlign.center,
            )),
            Container(
              width: 15,
              height: 1,
              color: Colors.grey[500],
            ),
            Expanded(child: Text("555", textAlign: TextAlign.center)),
            Container(
              width: 15,
              height: 1,
              color: Colors.grey[500],
            ),
            Expanded(child: Text("9898", textAlign: TextAlign.center))
          ],
        ),
        leading: leadingIcon,
        trailing: trailingIcon,
      ),
    );
  }
}
