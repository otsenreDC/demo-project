import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String message;

  Loading({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearProgressIndicator(
            value: null,
          ),
          Text(
            message,
            style: TextStyle(),
          ),
        ],
      ),
    );
  }
}
