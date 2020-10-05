// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CountStore on _CountStore, Store {
  final _$countAtom = Atom(name: '_CountStore.count');

  @override
  int get count {
    _$countAtom.reportRead();
    return super.count;
  }

  @override
  set count(int value) {
    _$countAtom.reportWrite(value, super.count, () {
      super.count = value;
    });
  }

  final _$_CountStoreActionController = ActionController(name: '_CountStore');

  @override
  void increment() {
    final _$actionInfo = _$_CountStoreActionController.startAction(
        name: '_CountStore.increment');
    try {
      return super.increment();
    } finally {
      _$_CountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrement() {
    final _$actionInfo = _$_CountStoreActionController.startAction(
        name: '_CountStore.decrement');
    try {
      return super.decrement();
    } finally {
      _$_CountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
count: ${count}
    ''';
  }
}
