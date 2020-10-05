import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial());

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    var count = 0;
    if (state is CounterCount){
      count = (state as CounterCount).count;
    }
    if (event is CounterIncrement){
      yield CounterCount(count + 1);
    } else if (event is CounterDecrement){
      yield CounterCount(count - 1);
    }
  }

  @override
  Stream<Transition<CounterEvent, CounterState>> transformEvents(Stream<CounterEvent> events, TransitionFunction<CounterEvent, CounterState> transitionFn) {
    return super.transformEvents(events, transitionFn).debounceTime(Duration(seconds: 1));
  }
}
