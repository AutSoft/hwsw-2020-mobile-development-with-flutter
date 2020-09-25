import 'package:awesome_todo_app/domain/model/todo.dart';
import 'package:awesome_todo_app/domain/model/todo_priority.dart';
import 'package:flutter/material.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final Function(int id) onTap;
  final Function(int id, bool isDone) onDoneChanged;
  final Function(int id) onDeletePressed;

  TodoListItem(
    this.todo, {
    @required this.onTap,
    @required this.onDoneChanged,
    @required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(todo.id),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TodoPriorityIndicator(todo.priority),
          ),
          Checkbox(
            value: todo.isDone,
            onChanged: (isDone) => onDoneChanged(todo.id, isDone),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(todo.title),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.grey,
            ),
            onPressed: () => onDeletePressed(todo.id),
          ),
        ],
      ),
    );
  }
}

class TodoPriorityIndicator extends StatelessWidget {
  final TodoPriority priority;

  TodoPriorityIndicator(this.priority);

  @override
  Widget build(BuildContext context) {
    Color indicatorColor;

    switch (priority) {
      case TodoPriority.LOW:
        indicatorColor = Colors.green;
        break;
      case TodoPriority.NORMAL:
        indicatorColor = Colors.yellow;
        break;
      case TodoPriority.HIGH:
        indicatorColor = Colors.red;
        break;
      default:
        throw ArgumentError(
          "A Todo has an invalid priority. This should never happen.",
        );
    }

    return Container(
      width: 16,
      height: 16,
      child: Material(
        shape: CircleBorder(),
        color: indicatorColor,
        elevation: 4,
      ),
    );
  }
}
