import 'package:awesome_todo_app/data/database/data_source.dart';
import 'package:awesome_todo_app/data/model/todo.dart';
import 'package:awesome_todo_app/ui/details/todo_details.dart';
import 'package:awesome_todo_app/ui/list/todo_list_item.dart';
import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  final DataSource dataSource;

  TodoListPage({Key key, this.dataSource}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState(dataSource);
}

class _TodoListPageState extends State<TodoListPage> {
  DataSource _todosDataSource;
  Future<List<Todo>> _todosFuture;

  _TodoListPageState(this._todosDataSource);

  @override
  void initState() {
    _todosFuture = _todosDataSource.getAllTodos();
    super.initState();
  }

  void onDoneChanged(int id, bool isDone) async {
    await _todosDataSource.setTodoDone(id, isDone);
    setState(() {
      _todosFuture = _todosDataSource.getAllTodos();
    });
  }

  void onDeletePressed(int id) async {
    await _todosDataSource.deleteTodo(id);
    setState(() {
      _todosFuture = _todosDataSource.getAllTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: FutureBuilder<List<Todo>>(
          future: _todosFuture,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasError) {
              return Center(
                child: Text(
                    "Oh no, something went wrong while loading the Todo list. :("),
              );
            }

            if (asyncSnapshot.hasData) {
              return ListView.builder(
                itemCount: asyncSnapshot.data.length,
                itemBuilder: (context, index) {
                  return TodoListItem(
                    asyncSnapshot.data[index],
                    onTap: (id) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>
                              TodoDetails(_todosDataSource, id))
                      );
                    },
                    onDoneChanged: (id, isDone) => onDoneChanged(id, isDone),
                    onDeletePressed: (id) => onDeletePressed(id),
                  );
                },
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              // builder: (_) => TodoDetails(),
            ),
          );
        },
        tooltip: 'New Todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
