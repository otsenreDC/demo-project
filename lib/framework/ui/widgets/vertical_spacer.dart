import 'package:flutter/cupertino.dart';

class VerticalSpacer extends StatelessWidget {
  final double _height;

  VerticalSpacer(this._height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this._height,
    );
  }
}
