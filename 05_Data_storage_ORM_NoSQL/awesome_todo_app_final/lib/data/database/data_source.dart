import '../model/todo.dart';
import 'todo_database.dart';

class DataSource {
  final TodoDatabase database;

  DataSource(this.database);

  Future<void> upsertTodo(Todo todo) {
   return database.upsertTodo(todo);
  }

  Future<void> deleteTodo(int id) async {
    return database.deleteTodo(id);
  }

  Future<Todo> getTodo(int id) async {
    return database.getTodo(id);
  }

  Future<List<Todo>> getAllTodos() async {
    return database.getAllTodos();
  }

  Future<void> setTodoDone(int id, bool isDone){
    return database.setTodoDone(id, isDone);
  }
}