import 'package:awesome_todo_app/data/database/floor/floor_todo.dart';
import 'package:awesome_todo_app/domain/model/todo_priority.dart';
import 'package:awesome_todo_app/util.dart';

import '../../domain/model/todo.dart';
import 'moor/moor_todo.dart';
import 'todo_repository.dart';

class DataSource {
  final TodoRepository<MoorTodoData> database;

  DataSource(this.database);

  Future<void> init() async {
    await database.init();
  }

  Future<List<Todo>> getAllTodos() async {
    final todos = await database.getAllTodos();
    return todos
        .map(
          (moorTodo) => moorTodo.toTodo(),
        )
        .toList();
  }

  Future<Todo> getTodo(int id) async {
    final moorTodo = await database.getTodo(id);
    return moorTodo.toTodo();
  }

  Future<void> upsertTodo(Todo todo) async {
    return database.upsertTodo(todo.toMoorTodoData());
  }

  Future<void> deleteTodo(Todo todo) async {
    return database.deleteTodo(todo.toMoorTodoData());
  }

  Future<void> setTodoDone(Todo todo, bool isDone) async {
    return database.upsertTodo(
      todo.toMoorTodoData().copyWith(isDone: isDone),
    );
  }
}

extension TodoToFloorTodo on Todo {
  FloorTodo toFloorTodo() {
    return FloorTodo(
        id: this.id,
        title: this.title,
        description: this.description,
        priority: this.priority.index,
        isDone: this.isDone ? 1 : 0,
        dueDate: getFormattedDate(this.dueDate));
  }
}

extension FloorTodoToTodo on FloorTodo {
  Todo toTodo() {
    TodoPriority priority;
    switch (this.priority) {
      case 0:
        priority = TodoPriority.LOW;
        break;
      case 1:
        priority = TodoPriority.NORMAL;
        break;
      case 2:
        priority = TodoPriority.HIGH;
        break;
      default:
        throw ArgumentError(
            "Invalid Todo priority encountered while mapping database object to domain object");
    }
    return Todo(
        id: this.id,
        title: this.title,
        description: this.description,
        priority: priority,
        isDone: this.isDone == 1 ? true : false,
        dueDate: parseDate(this.dueDate));
  }
}

extension TodoToMoorTodoData on Todo {
  MoorTodoData toMoorTodoData() {
    return MoorTodoData(
        id: this.id,
        title: this.title,
        description: this.description,
        priority: this.priority.index,
        isDone: this.isDone,
        dueDate: getFormattedDate(this.dueDate));
  }
}

extension MoorTodoDataToTodo on MoorTodoData {
  Todo toTodo() {
    TodoPriority priority;
    switch (this.priority) {
      case 0:
        priority = TodoPriority.LOW;
        break;
      case 1:
        priority = TodoPriority.NORMAL;
        break;
      case 2:
        priority = TodoPriority.HIGH;
        break;
      default:
        throw ArgumentError(
            "Invalid Todo priority encountered while mapping database object to domain object");
    }
    return Todo(
        id: this.id,
        title: this.title,
        description: this.description,
        priority: priority,
        isDone: this.isDone,
        dueDate: parseDate(this.dueDate));
  }
}
