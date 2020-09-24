import 'package:awesome_todo_app_starter/data/database/data_source.dart';
import 'package:awesome_todo_app_starter/data/database/memory/memory_todo_database.dart';
import 'package:flutter/widgets.dart';

class DataSourceProvider extends InheritedWidget {
  //region Constructor
  DataSourceProvider({Key key, Widget child}) : super(key: key, child: child);

  //endregion

  final DataSource dataSource = DataSource(
    MemoryTodoDatabase(),
    // FloorTodoDatabase()
    // MoorTodoDatabase()
    // SembastTodoDatabase()
    // HiveTodoDatabase()
  );

  //region InheritedWidget implementation
  static DataSourceProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataSourceProvider>();
  }

  @override
  bool updateShouldNotify(DataSourceProvider old) => false;
//endregion
}
