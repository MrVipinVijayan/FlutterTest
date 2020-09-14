import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:test_project/utils/validator.dart';

@immutable
abstract class RegisterState {}

class RegisterInitialState extends RegisterState {
  //
}

class RegistrationLoading extends RegisterState {
  //
}

class RegistrationFirstNameValidation extends RegisterState {
  final bool validated;
  RegistrationFirstNameValidation(this.validated);
}

class RegistrationLastNameValidation extends RegisterState {
  final bool validated;
  RegistrationLastNameValidation(this.validated);
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
  RegisterBloc() : super(RegisterInitialState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvents event) async* {
    if (event is FirstNameValidation) {
      bool validated = Validator.isFirstNameValid(event.firstName);
      yield RegistrationFirstNameValidation(validated);
    }
    if (event is LastNameValidation) {
      bool validated = Validator.isFirstNameValid(event.lastName);
      yield RegistrationLastNameValidation(validated);
    }
  }
}

abstract class RegisterEvents {}

class FirstNameValidation extends RegisterEvents {
  String firstName;
  FirstNameValidation(this.firstName);
}

class LastNameValidation extends RegisterEvents {
  String lastName;
  LastNameValidation(this.lastName);
}
