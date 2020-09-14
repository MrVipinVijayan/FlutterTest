import 'package:flutter/material.dart';
import 'package:test_project/bloc/reg_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstNameScreen extends StatelessWidget {
  //
  final Function onSubmitted;
  final TextEditingController controller = TextEditingController();

  FirstNameScreen({this.onSubmitted});

  @override
  Widget build(BuildContext context) {
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
            child: Text('Next'),
          )
        ],
      ),
    );
  }
}
