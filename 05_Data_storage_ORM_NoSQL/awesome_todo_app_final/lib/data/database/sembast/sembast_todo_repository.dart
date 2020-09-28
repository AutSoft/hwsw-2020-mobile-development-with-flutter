import 'package:awesome_todo_app/data/database/sembast/sembast_todo.dart';
import 'package:awesome_todo_app/data/database/todo_repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastTodoRepository implements TodoRepository<SembastTodo> {
  Database db;
  StoreRef todoStore = StoreRef.main();

  @override
  Future<void> init() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDir.path, "sembast_todo.db");
    db = await databaseFactoryIo.openDatabase(dbPath);
  }

  @override
  Future<List<SembastTodo>> getAllTodos() async {
    final snapshots = await todoStore.find(db);
    return snapshots
        .map((snapshot) => SembastTodo.fromMap(snapshot.key, snapshot.value))
        .toList();
  }

  @override
  Future<SembastTodo> getTodo(int id) async {
    final snapshot =
        await todoStore.findFirst(db, finder: Finder(filter: Filter.byKey(id)));
    return SembastTodo.fromMap(snapshot.key, snapshot.value);
  }

  @override
  Future<void> deleteTodo(SembastTodo todo) async {
    await todoStore.record(todo.id).delete(db);
  }

  @override
  Future<void> upsertTodo(SembastTodo todo) async {
    if (todo.id == null) {
      return await todoStore.add(db, todo.toMap());
    } else {
      return await todoStore.record(todo.id).put(db, todo.toMap());
    }
  }
}
