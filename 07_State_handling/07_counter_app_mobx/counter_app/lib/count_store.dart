import 'package:mobx/mobx.dart';

part 'count_store.g.dart';

class CountStore = _CountStore with _$CountStore;
abstract class _CountStore with Store{
  @observable
  int count = 0;

  @action
  void increment() => count++;

  @action
  void decrement() => count--;
}