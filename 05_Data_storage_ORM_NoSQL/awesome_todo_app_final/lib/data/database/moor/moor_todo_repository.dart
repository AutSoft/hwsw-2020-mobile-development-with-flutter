import 'package:awesome_todo_app/data/database/moor/moor_todo.dart';
import 'package:awesome_todo_app/data/database/moor/moor_todo_dao.dart';
import 'package:awesome_todo_app/data/database/todo_repository.dart';

class MoorTodoRepository implements TodoRepository<MoorTodoData> {
  MoorTodoDao todoDao;

  @override
  Future<void> init() async {
    final database = MoorTodoDatabase();
    todoDao = database.moorTodoDao;
  }

  @override
  Future<List<MoorTodoData>> getAllTodos() {
    return todoDao.getAllTodos();
  }

  @override
  Future<MoorTodoData> getTodo(int id) async {
    final todos = await todoDao.getTodo(id);
    return Future.value(todos.first);
  }

  @override
  Future<void> deleteTodo(MoorTodoData todo) {
    return todoDao.deleteTodo(todo);
  }

  @override
  Future<void> upsertTodo(MoorTodoData todo) {
    return todoDao.upsertTodo(todo);
  }
}
