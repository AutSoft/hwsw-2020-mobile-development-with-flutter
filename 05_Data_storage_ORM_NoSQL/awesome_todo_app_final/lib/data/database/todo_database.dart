
import 'package:awesome_todo_app/data/model/todo.dart';

abstract class TodoDatabase<T> {
  Future<List<T>> getAllTodos();

  Future<T> getTodo(int id);

  Future upsertTodo(T todo);

  Future deleteTodo(int id);

  Future setTodoDone(int id, bool isDone);
}