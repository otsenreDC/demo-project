import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_docere/texts.dart';

import '../../../colors.dart';

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
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        color:
            selected == true ? MedAppColors.lighterBlue : MedAppColors.black196,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: MedAppColors.black120,
                  ),
                  Text(
                    "$name",
                    style: MedAppTextStyle.header3(),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "$address",
                style: MedAppTextStyle.labelSmall(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
