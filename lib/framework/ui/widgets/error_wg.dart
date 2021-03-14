import 'package:flutter/cupertino.dart';

class Error extends StatelessWidget {
  final String message;

  Error({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(this.message),
      ),
    );
  }
}
