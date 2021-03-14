import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimpleCenterCard extends StatelessWidget {
  final String name;
  final String address;
  final bool selected;
  final Function onTap;

  const SimpleCenterCard(
      {Key key,
      @required this.name,
      @required this.address,
      this.selected = false,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        color: selected == true ? Colors.grey[500] : Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "$name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "$address",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
