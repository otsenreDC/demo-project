import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/domain/models/session.dart';
import 'package:project_docere/domain/view_models/doctors/doctor_list_vm.dart';
import 'package:project_docere/framework/ui/appointments/patient/appointment_list_pg.dart';
import 'package:project_docere/framework/ui/appointments/secretary/appointment_list_pg.dart';
import 'package:project_docere/framework/ui/doctors/doctor_list_pg.dart';
import 'package:project_docere/framework/ui/profile/profile_pg.dart';
import 'package:project_docere/texts.dart';
import 'package:provider/provider.dart';

const INDEX_DOCTORS = 0;
const INDEX_APPOINTMENTS = 1;
const INDEX_PROFILE = 2;

class Destination {
  const Destination(this.index, this.title, this.icon);

  final int index;
  final String title;
  final IconData icon;
}

const List<Destination> allDestinations = <Destination>[
  Destination(INDEX_DOCTORS, 'Doctores', Icons.home_outlined),
  Destination(INDEX_APPOINTMENTS, 'Citas', Icons.calendar_today_sharp),
  Destination(INDEX_PROFILE, 'Perfil', Icons.perm_identity),
];

class HomePage extends StatefulWidget {
  static final String routeName = "/home";

  @override
  State createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  List<Key> _destinationKeys;
  List<AnimationController> _faders;
  AnimationController _hide;
  int _currentIndex = INDEX_DOCTORS;
  Doctor _currentDoctor;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onDoctorSelected(Doctor doctor) {
    _currentDoctor = doctor;
    setState(() {
      _currentIndex = INDEX_APPOINTMENTS;
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case INDEX_APPOINTMENTS:
        {
          final rol = Provider.of<DoctorListViewModel>(context).sessionRol;
          Widget to;
          if (rol == Rol.Secretary) {
            if (_currentDoctor == null) {
              to = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Debe seleccionar un doctor",
                    maxLines: 4,
                    style: MedAppTextStyle.header2()
                        .copyWith(color: Colors.black87),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                    child: Text("Ir a Doctores"),
                  )
                ],
              );
            } else {
              to = AppointmentListSecretaryPage(
                _currentDoctor,
                goToDoctorListPage: () {
                  setState(() {
                    _currentIndex = INDEX_DOCTORS;
                  });
                },
              );
            }
          } else
            to = AppointmentListPage();
          return to;
        }
      case INDEX_PROFILE:
        return ProfilePage();
      case INDEX_DOCTORS:
      default:
        {
          final rol = Provider.of<DoctorListViewModel>(context).sessionRol;
          final onDoctorSelected =
              rol == Rol.Secretary ? _onDoctorSelected : null;
          return DoctorListPage(onDoctorSelected: onDoctorSelected);
        }
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
