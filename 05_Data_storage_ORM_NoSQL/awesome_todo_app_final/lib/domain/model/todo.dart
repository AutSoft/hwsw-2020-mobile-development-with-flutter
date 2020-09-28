import 'package:awesome_todo_app/domain/model/todo_priority.dart';

class Todo {
  int id;
  String title;
  DateTime dueDate;
  bool isDone;
  String description;
  TodoPriority priority;

  Todo({
    this.id,
    this.title,
    this.dueDate,
    this.isDone,
    this.description,
    this.priority,
  });
}
