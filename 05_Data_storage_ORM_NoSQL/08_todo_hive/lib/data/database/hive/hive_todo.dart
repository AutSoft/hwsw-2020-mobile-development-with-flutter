import 'package:hive/hive.dart';

part 'hive_todo.g.dart';

@HiveType(typeId: 0)
class HiveTodo extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime dueDate;

  @HiveField(3)
  bool isDone;

  @HiveField(4)
  String description;

  @HiveField(5)
  int priority;

  HiveTodo({
    this.id,
    this.title,
    this.dueDate,
    this.isDone,
    this.description,
    this.priority,
  });
}