import 'package:flutter/material.dart';

class Retry extends StatelessWidget {
  //
  final String message;
  final Function onTap;

  Retry({this.message, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
            ),
            FlatButton(
              child: Text(
                'Tap to Retry',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
