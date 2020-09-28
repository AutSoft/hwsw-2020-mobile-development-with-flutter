import 'package:floor/floor.dart';

@Entity(tableName: "todo")
class FloorTodo {
  @PrimaryKey(autoGenerate: true)
  int id;
  String title;
  String dueDate;
  int isDone;
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
