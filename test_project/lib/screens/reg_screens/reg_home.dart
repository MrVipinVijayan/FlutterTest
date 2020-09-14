import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/bloc/reg_bloc.dart';
import 'package:test_project/models/reg_model.dart';
import 'package:test_project/screens/reg_screens/first_name.dart';
import 'package:test_project/screens/reg_screens/last_name.dart';
import 'package:test_project/screens/reg_screens/reg_success.dart';
import 'package:test_project/widgets/error_txt.dart';

class RegHomeScreen extends StatefulWidget {
  @override
  _RegHomeScreenState createState() => _RegHomeScreenState();
}

class _RegHomeScreenState extends State<RegHomeScreen> {
  //
  int _screenId = 0;
  String _errMessage;
  RegisterModel _registerModel;

  @override
  void initState() {
    super.initState();
    _registerModel = RegisterModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: BlocProvider(
        create: (context) => RegisterBloc(),
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (BuildContext context, RegisterState state) {
            if (state is FirstNameSuccess) {
              _screenId = 1;
              _errMessage = null;
            }
            if (state is FirstNameError) {
              _errMessage = state.errorMessage;
            }
            if (state is LastNameError) {
              _errMessage = state.errorMessage;
            }
            if (state is RegistrationCompleted) {
              _screenId = 2;
              _registerModel = state.registerModel;
              print('Registration Completed ${_registerModel.firstName}');
            }
            return regUI(context);
          },
        ),
      ),
    );
  }

  Widget regUI(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Visibility(
                visible: 0 == _screenId,
                child: FirstNameScreen(
                  onSubmitted: (text) {
                    context
                        .bloc<RegisterBloc>()
                        .add(FirstNameValidationEvent(text));
                  },
                ),
              ),
              Visibility(
                visible: 1 == _screenId,
                child: LastNameScreen(
                  onSubmitted: (text) {
                    context
                        .bloc<RegisterBloc>()
                        .add(LastNameValidationEvent(text));
                  },
                ),
              ),
              Visibility(
                visible: 2 == _screenId,
                child: RegSuccessScreen(),
              )
            ],
          ),
          null != _errMessage ? ErrorTxt(text: _errMessage) : Container(),
          SizedBox(width: 50),
        ],
      ),
    );
  }
}
