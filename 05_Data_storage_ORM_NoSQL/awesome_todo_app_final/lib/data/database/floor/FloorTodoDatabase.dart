import 'package:awesome_todo_app_starter/data/database/todo_database.dart';
import 'package:awesome_todo_app_starter/data/model/todo.dart';

class FloorTodoDatabase implements TodoDatabase {
  @override
  Future deleteTodo(int id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<List<Todo>> getAllTodos() {
    // TODO: implement getAllTodos
    throw UnimplementedError();
  }

  @override
  Future<Todo> getTodo(int id) {
    // TODO: implement getTodo
    throw UnimplementedError();
  }

  @override
  Future setTodoDone(int id, bool isDone) {
    // TODO: implement setTodoDone
    throw UnimplementedError();
  }

  @override
  Future upsertTodo(Todo todo) {
    // TODO: implement upsertTodo
    throw UnimplementedError();
  }
}