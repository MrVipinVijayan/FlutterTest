import 'package:flutter/material.dart';

class TitleTxt extends StatelessWidget {
  //
  final String text;

  TitleTxt({this.text}) : assert(null != text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
