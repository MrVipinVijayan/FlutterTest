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
  RegisterModel _registerModel;
  String _firstName;
  String _lastName;

  @override
  void initState() {
    super.initState();
    _registerModel = RegisterModel();
    _registerModel.firstName = _firstName;
    _registerModel.lastName = _lastName;
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
            String message = '';
            message = processRegistrationEvents(state, message);
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
                              _firstName = text;
                              context
                                  .bloc<RegisterBloc>()
                                  .add(FirstNameValidation(text));
                            },
                          ),
                        ),
                        Visibility(
                          visible: 1 == _screenId,
                          child: LastNameScreen(
                            onSubmitted: (text) {
                              _lastName = text;
                              context
                                  .bloc<RegisterBloc>()
                                  .add(LastNameValidation(text));
                            },
                          ),
                        ),
                        Visibility(
                          visible: 2 == _screenId,
                          child: RegSuccessScreen(),
                        )
                      ],
                    ),
                    ErrorTxt(text: message),
                    SizedBox(width: 50),
                  ],
                ));
          },
        ),
      ),
    );
  }

  String processRegistrationEvents(RegisterState state, String message) {
    if (state is RegistrationFirstNameValidation) {
      if (state.validated) {
        _registerModel.firstName = _firstName;
        _screenId = 1;
        return '';
      }
      message = 'First name invalid';
    }
    if (state is RegistrationLastNameValidation) {
      if (state.validated) {
        _registerModel.lastName = _lastName;
        _screenId = 2;
        return '';
      }
      message = 'Last name invalid';
    }
    return message;
  }
}
