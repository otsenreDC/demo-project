import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_docere/domain/models/doctor.dart';

class DoctorPatientCard extends StatelessWidget {
  final Doctor doctor;
  final Function(Doctor) onTap;
  final bool isSelected;

  DoctorPatientCard({
    @required this.doctor,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(doctor),
      child: Card(
        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        color: isSelected ? Colors.lightBlueAccent[200] : Colors.grey[200],
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                maxRadius: 25,
                minRadius: 25,
                backgroundImage: NetworkImage(
                  "https://cdn2.iconfinder.com/data/icons/avatar-business-people-set-one/128/avatar-25-512.png",
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.fullName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    doctor.specialty,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DoctorSecretaryCard extends StatelessWidget {
  final Doctor doctor;
  final Function(Doctor) onTap;
  final bool isSelected;

  DoctorSecretaryCard({
    @required this.doctor,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(doctor),
      child: Card(
        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        color: isSelected ? Colors.lightBlueAccent[200] : Colors.grey[200],
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                maxRadius: 25,
                minRadius: 25,
                backgroundImage: NetworkImage(
                  "https://cdn2.iconfinder.com/data/icons/avatar-business-people-set-one/128/avatar-25-512.png",
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    doctor.specialty,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
