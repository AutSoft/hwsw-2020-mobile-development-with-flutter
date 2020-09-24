import 'package:awesome_todo_app/data/database/data_source.dart';
import 'package:awesome_todo_app/data/model/todo.dart';
import 'package:awesome_todo_app/ui/list/todo_list_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoDetails extends StatefulWidget {
  final DataSource dataSource;
  final int todoId;

  TodoDetails(this.dataSource, this.todoId);

  @override
  _TodoDetailsState createState() => _TodoDetailsState(dataSource, todoId);
}

class _TodoDetailsState extends State<TodoDetails> {
  final DataSource dataSource;
  final int todoId;

  Future<Todo> todoFuture;

  _TodoDetailsState(this.dataSource, this.todoId);

  @override
  void initState() {
    todoFuture = dataSource.getTodo(todoId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<Todo>(
          future: todoFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("The requested todo cannot be found."),
              );
            }

            if (snapshot.hasData) {
              final todo = snapshot.data;
              return Column(
                children: [
                  Row(
                    children: [
                      TodoPriorityIndicator(todo.priority),
                      Checkbox(
                        value: todo.isDone,
                        onChanged: null,
                      ),
                      TodoDataRow(
                        rowTitle: "",
                        rowData: todo.title,
                      ),
                    ],
                  ),
                  TodoDataRow(
                    rowTitle: "Description",
                    rowData: todo.description,
                  ),
                  TodoDataRow(
                    rowTitle: "Due date",
                    rowData: DateFormat("yyyy.MM.dd.").format(todo.dueDate),
                  ),
                ],
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class TodoDataRow extends StatelessWidget {
  final String rowTitle;
  final String rowData;

  const TodoDataRow({Key key, this.rowTitle, this.rowData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          rowTitle.isNotEmpty ? Text("$rowTitle: ") : Container(),
          Text(rowData),
        ],
      ),
    );
  }
}

/*DropdownButton(
value: todo.priority,
onChanged: (todoPriority) => _setTodoPriority(todoPriority),
items: [
DropdownMenuItem(
onTap: () {},
value: TodoPriority.LOW,
child: Text("LOW"),
),
DropdownMenuItem(
onTap: () {},
value: TodoPriority.NORMAL,
child: Text("NORMAL"),
),
DropdownMenuItem(
onTap: () {},
value: TodoPriority.HIGH,
child: Text("HIGH"),
),
],
)*/
