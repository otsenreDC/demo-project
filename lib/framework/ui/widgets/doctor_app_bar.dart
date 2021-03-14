import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorAppBar extends StatelessWidget {
  final String fullName;
  final String specialty;

  DoctorAppBar({@required this.fullName, @required this.specialty});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
                color: Colors.blue[900],
              ),
              margin: const EdgeInsets.only(right: 30, bottom: 20, top: 60),
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              width: double.infinity,
              child: Row(
                children: [
                  CircleAvatar(
                    maxRadius: 25,
                    minRadius: 25,
                    backgroundImage: NetworkImage(
                      "https://cdn2.iconfinder.com/data/icons/avatar-business-people-set-one/128/avatar-25-512.png",
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this.fullName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        this.specialty,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
