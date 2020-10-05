part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

class CounterIncrement extends CounterEvent{}
class CounterDecrement extends CounterEvent{}
