part of 'counter_cubit.dart';

@immutable
abstract class CounterState{}

class CounterInitial extends CounterState {}

class CounterCount extends CounterState {
  final int count;

  CounterCount(this.count);
}
