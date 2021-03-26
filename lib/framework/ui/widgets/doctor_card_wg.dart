import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_docere/colors.dart';
import 'package:project_docere/domain/models/doctor.dart';
import 'package:project_docere/framework/ui/widgets/summary_item.dart';
import 'package:project_docere/texts.dart';

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
        color: isSelected ? MedAppColors.lightBlue : MedAppColors.gray,
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
      onTap: () {
        if (onTap != null) onTap(doctor);
      },
      child: Card(
          margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          color: Colors.grey[200],
          child: Column(
            children: [
              Container(
                height: 132,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          "https://cdn2.iconfinder.com/data/icons/avatar-business-people-set-one/128/avatar-25-512.png",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            doctor.fullName,
                            style: MedAppTextStyle.header1(),
                          ),
                          SizedBox(height: 16),
                          Text(doctor.specialty),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: MedAppColors.blue,
                height: 56,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SummaryItem("Atendidos", 2),
                    SummaryItem("En espera", 4),
                    SummaryItem("Pendiente", 2),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: MedAppColors.green,
                ),
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Próximo paciente:",
                        style: MedAppTextStyle.header3(),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              "https://image.flaticon.com/icons/png/512/1430/1430453.png",
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Ricardo López"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
