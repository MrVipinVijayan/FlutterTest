import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/bloc/reg_bloc.dart';

class LastNameScreen extends StatelessWidget {
  //
  final Function onSubmitted;
  final TextEditingController controller = TextEditingController();

  LastNameScreen({this.onSubmitted});

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
              //onSubmitted(controller.text);
              context
                  .bloc<RegisterBloc>()
                  .add(LastNameValidation(controller.text));
            },
            child: Text('Done'),
          )
        ],
      ),
    );
  }
}
