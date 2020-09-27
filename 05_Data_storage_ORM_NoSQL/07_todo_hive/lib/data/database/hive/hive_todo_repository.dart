import 'package:awesome_todo_app/data/database/todo_repository.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'hive_todo.dart';

class HiveTodoRepository implements TodoRepository<HiveTodo> {
  static const HIVE_TODO_BOX = 'hive_todo';

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HiveTodoAdapter());
  }

  @override
  Future<List<HiveTodo>> getAllTodos() async {
    List<HiveTodo> todos;
    await withHiveTodoBox((box) async {
      todos = box.values.toList() ?? [];
    });
    return Future.value(todos);
  }

  @override
  Future<HiveTodo> getTodo(int id) async {
    HiveTodo hiveTodo;
    await withHiveTodoBox((box) async {
      hiveTodo = box.get(id);
    });
    return hiveTodo;
  }

  @override
  Future<void> deleteTodo(HiveTodo todo) async {
    return await withHiveTodoBox((box) async {
      await box.delete(todo.id);
    });
  }

  @override
  Future<void> upsertTodo(HiveTodo todo) async {
    return await withHiveTodoBox((box) async {
      if (todo.id == null) {
        final id = await box.add(todo);
        todo.id = id;
        todo.save();
      } else {
        await box.put(todo.key, todo);
      }
    });
  }

  Future<void> withHiveTodoBox(Future<void> Function(Box<HiveTodo> box) task) async {
    final box = await Hive.openBox<HiveTodo>(HIVE_TODO_BOX);
    await task(box);
    await box.close();
  }
}
