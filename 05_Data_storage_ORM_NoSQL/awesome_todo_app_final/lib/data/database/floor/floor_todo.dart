import 'package:floor/floor.dart';

@Entity(tableName: "todo")
class FloorTodo {
  @primaryKey
  int id;
  String title;
  String dueDate;
  bool isDone;
  String description;
  int priority;

  FloorTodo({
    this.id,
    this.title,
    this.dueDate,
    this.isDone,
    this.description,
    this.priority,
  });
}
