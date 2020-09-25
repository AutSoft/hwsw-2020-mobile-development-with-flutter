import 'dart:math';

import 'package:awesome_todo_app/data/database/todo_database.dart';
import 'package:awesome_todo_app/domain/model/todo.dart';
import 'package:awesome_todo_app/domain/model/todo_priority.dart';

class MemoryTodoDatabase implements TodoDatabase<Todo> {
  final List<Todo> todos = [
    Todo(
      id: 0,
      title: "Update GitHub repo",
      dueDate: DateTime(2020, 9, 28),
      isDone: true,
      description: "git pull",
      priority: TodoPriority.NORMAL,
    ),
    Todo(
      id: 1,
      title: "Join Adobe Connect room",
      dueDate: DateTime(2020, 9, 28),
      isDone: true,
      description: "https://hwsw.adobeconnect.com/flutter/",
      priority: TodoPriority.NORMAL,
    ),
    Todo(
      id: 2,
      title: "Have fun learning! :)",
      dueDate: DateTime(2020, 9, 28),
      isDone: false,
      description: "Don't forget to ask questions!",
      priority: TodoPriority.HIGH,
    )
  ];

  @override
  Future<void> deleteTodo(int id) {
    return Future(() {
      todos.removeWhere((element) => element.id == id);
    });
  }

  @override
  Future<List<Todo>> getAllTodos() {
    return Future.value(todos);
  }

  @override
  Future<Todo> getTodo(int id) {
    return Future.value(
      todos.firstWhere((element) => element.id == id),
    );
  }

  @override
  Future<void> upsertTodo(Todo todo) async {
    return Future(() {
      final index = todos.indexWhere((element) => element.id == todo.id);
      if (index == -1) {
        if (todo.id == 0 || todo.id == null) {
          todo.id = todos.map((element) => element.id).toList().reduce(max) + 1;
        }
        todos.add(todo);
        return;
      } else {
        todos[index] = todo;
      }
    });
  }

  @override
  Future<void> setTodoDone(int id, bool isDone) {
    return Future(() {
      final index = todos.indexWhere((element) => element.id == id);
      if (index == -1) {
        return;
      } else {
        todos[index].isDone = isDone;
      }
    });
  }
}
