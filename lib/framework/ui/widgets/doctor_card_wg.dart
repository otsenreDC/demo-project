import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_docere/domain/models/doctor.dart';

class DoctorCardWidget extends StatelessWidget {
  final Doctor doctor;
  final Function(Doctor) onTap;

  DoctorCardWidget({@required this.doctor, this.onTap});

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
        color: Colors.grey[200],
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CircleAvatar(
                maxRadius: 30,
                minRadius: 30,
                backgroundImage: NetworkImage(
                  "https://cdn2.iconfinder.com/data/icons/avatar-business-people-set-one/128/avatar-25-512.png",
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    doctor.specialty,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 15,
                      ),
                      Text(
                        "AQUI LA CLINICA",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
