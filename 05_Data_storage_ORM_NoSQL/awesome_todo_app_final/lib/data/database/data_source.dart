import 'package:awesome_todo_app/data/database/floor/floor_todo.dart';
import 'package:awesome_todo_app/data/database/hive/hive_todo.dart';
import 'package:awesome_todo_app/data/database/sembast/sembast_todo.dart';
import 'package:awesome_todo_app/domain/model/todo_priority.dart';
import 'package:awesome_todo_app/util.dart';

import '../../domain/model/todo.dart';
import 'moor/moor_todo.dart';
import 'todo_repository.dart';

class DataSource {
  final TodoRepository<HiveTodo> database;

  DataSource(this.database);

  Future<void> init() async {
    await database.init();
  }

  Future<List<Todo>> getAllTodos() async {
    final todos = await database.getAllTodos();
    return todos
        .map(
          (hiveTodo) => hiveTodo.toTodo(),
        )
        .toList();
  }

  Future<Todo> getTodo(int id) async {
    final hiveTodo = await database.getTodo(id);
    return hiveTodo.toTodo();
  }

  Future<void> upsertTodo(Todo todo) async {
    return database.upsertTodo(todo.toHiveTodo());
  }

  Future<void> deleteTodo(Todo todo) async {
    return database.deleteTodo(todo.toHiveTodo());
  }

  Future<void> setTodoDone(Todo todo, bool isDone) async {
    return database.upsertTodo(todo.toHiveTodo()..isDone = isDone);
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
    return Todo(
      id: this.id,
      title: this.title,
      description: this.description,
      priority: todoPriorityFromInt(this.priority),
      isDone: this.isDone == 1 ? true : false,
      dueDate: parseDate(this.dueDate),
    );
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
      dueDate: getFormattedDate(this.dueDate),
    );
  }
}

extension MoorTodoDataToTodo on MoorTodoData {
  Todo toTodo() {
    return Todo(
      id: this.id,
      title: this.title,
      description: this.description,
      priority: todoPriorityFromInt(this.priority),
      isDone: this.isDone,
      dueDate: parseDate(this.dueDate),
    );
  }
}

extension TodoToSembastTodo on Todo {
  SembastTodo toSembastTodo() {
    return SembastTodo(
      id: this.id,
      title: this.title,
      description: this.description,
      priority: this.priority.index,
      isDone: this.isDone,
      dueDate: getFormattedDate(this.dueDate),
    );
  }
}

extension SembastTodoToTodo on SembastTodo {
  Todo toTodo() {
    return Todo(
      id: this.id,
      title: this.title,
      description: this.description,
      priority: todoPriorityFromInt(this.priority),
      isDone: this.isDone,
      dueDate: parseDate(this.dueDate),
    );
  }
}

extension TodoToHiveTodo on Todo {
  HiveTodo toHiveTodo() {
    return HiveTodo(
      id: this.id,
      title: this.title,
      description: this.description,
      priority: this.priority.index,
      isDone: this.isDone,
      dueDate: this.dueDate,
    );
  }
}

extension HiveTodoToTodo on HiveTodo {
  Todo toTodo() {
    return Todo(
      id: this.id,
      title: this.title,
      description: this.description,
      priority: todoPriorityFromInt(this.priority),
      isDone: this.isDone,
      dueDate: this.dueDate,
    );
  }
}
