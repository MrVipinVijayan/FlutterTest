import 'package:flutter/material.dart';

class ErrorTxt extends StatelessWidget {
  //
  final String text;

  ErrorTxt({this.text}) : assert(null != text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.red,
        ),
      ),
    );
  }
}
