import '../../domain/model/todo.dart';
import 'todo_database.dart';

class DataSource {
  final TodoDatabase database;

  DataSource(this.database);

  Future<void> upsertTodo(Todo todo) async {
    // TODO Map the domain representation to the DB representation
   return database.upsertTodo(todo);
  }

  Future<void> deleteTodo(int id) async {
    return database.deleteTodo(id);
  }

  Future<Todo> getTodo(int id) async {
    // TODO Map the the DB representation to the domain representation
    return database.getTodo(id);
  }

  Future<List<Todo>> getAllTodos() async {
    // TODO Map the DB Todos to domain Todos
    return database.getAllTodos();
  }

  Future<void> setTodoDone(int id, bool isDone) async {
    return database.setTodoDone(id, isDone);
  }
}