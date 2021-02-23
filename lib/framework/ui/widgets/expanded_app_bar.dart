import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandedAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          )
        ],
      ),
      padding: EdgeInsets.only(left: 20),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Buen día usuario!",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Icon(Icons.wb_sunny)
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Selecciona tu doctor",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
