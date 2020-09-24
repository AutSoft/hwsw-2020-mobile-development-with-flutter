
import 'package:awesome_todo_app/data/model/todo.dart';

abstract class TodoDatabase {
  Future<List<Todo>> getAllTodos();

  Future<Todo> getTodo(int id);

  Future upsertTodo(Todo todo);

  Future deleteTodo(int id);

  Future setTodoDone(int id, bool isDone);
}