
import 'file:///C:/Users/juhos.istvan/Dropbox/SoftwareProjects/HWSW/flutter2020/05_Data_storage_ORM_NoSQL/awesome_todo_app_final/lib/domain/model/todo.dart';

abstract class TodoDatabase<T> {
  Future<List<T>> getAllTodos();

  Future<T> getTodo(int id);

  Future upsertTodo(T todo);

  Future deleteTodo(int id);

  Future setTodoDone(int id, bool isDone);
}