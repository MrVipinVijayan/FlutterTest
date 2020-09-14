import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:test_project/models/reg_model.dart';
import 'package:test_project/utils/validator.dart';

@immutable
abstract class RegisterState {}

class RegisterInitialState extends RegisterState {
  //
}

class RegistrationLoading extends RegisterState {
  //
}

class FirstNameSuccess extends RegisterState {
  FirstNameSuccess();
}

class FirstNameError extends RegisterState {
  final errorMessage;
  FirstNameError(this.errorMessage);
}

class LastNameError extends RegisterState {
  final errorMessage;
  LastNameError(this.errorMessage);
}

class RegistrationCompleted extends RegisterState {
  final RegisterModel registerModel;
  RegistrationCompleted(this.registerModel);
}

class RegistrationLoaded extends RegisterState {
  final bool loaded;
  RegistrationLoaded(this.loaded);
}

class RegistrationError extends RegisterState {
  final error;
  RegistrationError({this.error});
}

class RegisterBloc extends Bloc<RegisterEvents, RegisterState> {
  //
  RegisterModel registerModel = RegisterModel();

  RegisterBloc() : super(RegisterInitialState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvents event) async* {
    if (event is FirstNameValidationEvent) {
      bool validated = Validator.isNameValid(event.firstName);
      if (validated) {
        registerModel.firstName = event.firstName;
        yield FirstNameSuccess();
        return;
      }
      yield FirstNameError("First Name Invalid");
    }
    if (event is LastNameValidationEvent) {
      bool validated = Validator.isNameValid(event.lastName);
      if (validated) {
        registerModel.lastName = event.lastName;
        yield RegistrationCompleted(registerModel);
        return;
      }
      yield LastNameError("Last Name Invalid");
    }
  }
}

abstract class RegisterEvents {}

class FirstNameValidationEvent extends RegisterEvents {
  String firstName;
  FirstNameValidationEvent(this.firstName);
}

class LastNameValidationEvent extends RegisterEvents {
  String lastName;
  LastNameValidationEvent(this.lastName);
}

class RegistrationDoneEvent extends RegisterEvents {
  //
}
