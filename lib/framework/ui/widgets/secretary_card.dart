import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SecretaryCard extends StatelessWidget {
  final String name;
  final String phoneNumber;

  SecretaryCard({this.name, this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      color: Colors.grey[200],
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: CircleAvatar(
              maxRadius: 24,
              minRadius: 24,
              backgroundImage: NetworkImage(
                "https://cdn2.iconfinder.com/data/icons/avatar-business-people-set-one/128/avatar-25-512.png",
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    phoneNumber,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
