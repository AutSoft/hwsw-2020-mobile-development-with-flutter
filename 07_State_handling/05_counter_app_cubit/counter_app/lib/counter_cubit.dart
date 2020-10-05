import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  void increment(){
    if (state is CounterInitial){
      emit(CounterCount(1));
    } else {
      emit(CounterCount((state as CounterCount).count + 1));
    }
  }

  void decrement(){
    if (state is CounterInitial){
      emit(CounterCount(-1));
    } else {
      emit(CounterCount((state as CounterCount).count - 1));
    }
  }
}
