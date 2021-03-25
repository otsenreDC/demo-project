import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_docere/domain/models/session.dart';
import 'package:project_docere/domain/view_models/doctors/doctor_list_vm.dart';
import 'package:project_docere/framework/ui/appointments/patient/appointment_list_pg.dart';
import 'package:project_docere/framework/ui/appointments/secretary/appointment_list_pg.dart';
import 'package:project_docere/framework/ui/doctors/doctor_list_pg.dart';
import 'package:project_docere/framework/ui/profile/profile_pg.dart';
import 'package:provider/provider.dart';

class Destination {
  const Destination(this.index, this.title, this.icon);

  final int index;
  final String title;
  final IconData icon;
}

const List<Destination> allDestinations = <Destination>[
  Destination(0, 'Doctores', Icons.home_outlined),
  Destination(1, 'Citas', Icons.calendar_today_sharp),
  Destination(2, 'Perfil', Icons.perm_identity),
];

class HomePage extends StatefulWidget {
  static final String routeName = "/";

  @override
  State createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  String _title = 'Doctores';
  List<Key> _destinationKeys;
  List<AnimationController> _faders;
  AnimationController _hide;
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _title = allDestinations[index].title;
      _currentIndex = index;
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case 1:
        {
          final rol = Provider.of<DoctorListViewModel>(context).sessionRol;
          Widget to;
          if (rol == Rol.Secretary)
            to = AppointmentListSecretaryPage();
          else
            to = AppointmentListPage();
          return to;
        }
      case 2:
        return ProfilePage();
      default:
        return DoctorListPage();
    }
  }

  @override
  void initState() {
    super.initState();
    _faders =
        allDestinations.map<AnimationController>((Destination destination) {
      return AnimationController(
          vsync: this, duration: Duration(milliseconds: 200));
    }).toList();
    _faders[_currentIndex].value = 1.0;
    _destinationKeys =
        List<Key>.generate(allDestinations.length, (int index) => GlobalKey())
            .toList();
    _hide = AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  @override
  void dispose() {
    for (AnimationController controller in _faders) controller.dispose();
    _hide.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            _hide.forward();
            break;
          case ScrollDirection.reverse:
            _hide.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        // PreferredSize(
        //   preferredSize: Size.fromHeight(120),
        //   child: ExpandedAppBar(),
        // ),
        body: Stack(
          children: allDestinations.map(
            (Destination destination) {
              final Widget view = FadeTransition(
                opacity: _faders[destination.index]
                    .drive(CurveTween(curve: Curves.fastOutSlowIn)),
                child: KeyedSubtree(
                  key: _destinationKeys[destination.index],
                  child: _getPage(destination.index),
                ),
              );

              if (destination.index == _currentIndex) {
                _faders[destination.index].forward();
                return view;
              } else {
                _faders[destination.index].reverse();
                if (_faders[destination.index].isAnimating) {
                  return IgnorePointer(child: view);
                }
                return Offstage(child: view);
              }
            },
          ).toList(),
          fit: StackFit.expand,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: allDestinations.map((Destination destination) {
            return BottomNavigationBarItem(
              label: destination.title,
              icon: Icon(destination.icon),
            );
          }).toList(),
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
