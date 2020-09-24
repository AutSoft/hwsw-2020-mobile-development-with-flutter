import 'package:flutter/widgets.dart';

import 'database/data_source.dart';
import 'database/memory/memory_todo_database.dart';

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
