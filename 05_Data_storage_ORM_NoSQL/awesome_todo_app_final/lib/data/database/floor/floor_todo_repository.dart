import 'package:awesome_todo_app/data/database/todo_repository.dart';

import 'floor_todo.dart';

class FloorTodoRepository implements TodoRepository<FloorTodo> {

  @override
  Future<void> init() async {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<List<FloorTodo>> getAllTodos() {
    // TODO: implement getAllTodos
    throw UnimplementedError();
  }

  @override
  Future<FloorTodo> getTodo(int id) {
    // TODO: implement getTodo
    throw UnimplementedError();
  }

  @override
  Future<void> setTodoDone(FloorTodo todo, bool isDone) {
    // TODO: implement setTodoDone
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTodo(FloorTodo todo) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<void> upsertTodo(FloorTodo todo) {
    // TODO: implement upsertTodo
    throw UnimplementedError();
  }
}
