import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class CounterBloc extends Bloc<CounterEvent, int> {
  //
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield state + 1;
        break;
      case CounterEvent.decrement:
        yield state - 1;
        break;
    }
  }
}

enum CounterEvent {
  increment,
  decrement,
}
