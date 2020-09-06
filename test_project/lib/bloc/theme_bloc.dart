import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'package:test_project/utils/theme.dart';

class ThemeState {
  final ThemeData themeData;
  ThemeState({this.themeData});
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  //
  ThemeBloc()
      : super(
            ThemeState(themeData: AppThemes.appThemeData[AppTheme.lightTheme]));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeEvent) {
      // print(event.appTheme);
      yield ThemeState(themeData: AppThemes.appThemeData[event.appTheme]);
    }
  }
}

class ThemeEvent {
  final AppTheme appTheme;
  ThemeEvent({this.appTheme});
}
