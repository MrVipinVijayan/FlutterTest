import 'package:flutter/material.dart';

class LastNameScreen extends StatelessWidget {
  //
  final Function onSubmitted;
  final TextEditingController controller = TextEditingController();
  final String text;

  LastNameScreen({this.onSubmitted, this.text});

  @override
  Widget build(BuildContext context) {
    if (null != text) {
      controller.text = text;
    }
    return Container(
      child: Column(
        children: [
          TextField(
            controller: controller,
          ),
          FlatButton(
            onPressed: () {
              onSubmitted(controller.text);
            },
            child: Text('Done'),
          )
        ],
      ),
    );
  }
}
