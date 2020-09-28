# 05 Data storage, ORM, NoSQL

# ImageDownloader

```dart
class _ImageDownloaderPageState extends State<ImageDownloaderPage> {
    // ...
    
    Future<Directory> _getImagesDirectory() async {
      final directory = await getApplicationDocumentsDirectory();
      return Directory(path.join(directory.path, IMAGES_DIR)).create();
    }
    
    void _downloadNewImage() async {
      final response = await http.get("https://picsum.photos/400");
      final imagesDir = await _getImagesDirectory();
      final filePath = path.join(
        imagesDir.path,
        "${DateTime.now().toIso8601String()}.jpg",
      );
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      print("Image downloaded to: $filePath");
        
      setState(() {
        _imageFiles = _loadImages();
      });
    }
    
    Future<List<File>> _loadImages() async {
      final imagesDir = await _getImagesDirectory();
      return imagesDir.list()
          .where((element) => element.path.endsWith(".jpg"))
          .map((e) => File(e.path))
          .toList();
    }
    
    // Scaffold body
    
    FutureBuilder<List<File>>(
          future: _imageFiles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final imageFiles = snapshot.data;
              return GridView.builder(
                controller: scrollController,
                itemCount: imageFiles.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Image.file(imageFiles[index]);
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    
    // Scaffold FAB
    
    FloatingActionButton(
        onPressed: _downloadNewImage,
        tooltip: 'Download image',
        child: Icon(Icons.file_download),
      ),
    
    
```

# AwesomeTodoApp

## In-memory

### DataSource

```dart
class DataSource {
  final TodoDatabase<Todo> database;

  DataSource(this.database);

  Future<List<Todo>> getAllTodos() async {
    return database.getAllTodos();
  }

  Future<Todo> getTodo(int id) async {
    return database.getTodo(id);
  }

  Future<void> upsertTodo(Todo todo) async {
    return database.upsertTodo(todo);
  }

  Future<void> deleteTodo(Todo todo) async {
    return database.deleteTodo(todo);
  }

  Future<void> setTodoDone(Todo todo, bool isDone) async {
    return database.setTodoDone(todo, isDone);
  }
}
```

## shared_preferences

*todo_list.dart*

```dart
class _TodoListPageState extends State<TodoListPage> {
  // ...
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static const HIDE_DONE_TODOS_KEY = "HIDE_DONE_TODOS";
  Future<bool> _hideDoneTodos;
    
  // ...
  void initState() {
    _todosFuture = _todosDataSource.getAllTodos();
    _hideDoneTodos = _prefs.then((prefs) {
      return prefs.getBool(HIDE_DONE_TODOS_KEY) ?? false;
    });
    super.initState();
  }
    
  // ...
}
```

```dart
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        actions: [
          PopupMenuButton(
            onSelected: onPopupMenuItemClicked,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: HIDE_DONE_TODOS_KEY,
                  child: Row(
                    children: [
                      Text("Hide done todos"),
                      FutureBuilder<bool>(
                        future: _hideDoneTodos,
                        builder: (context, snapshot) {
                          if (snapshot.hasError ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return Checkbox(
                              tristate: true,
                              value: null,
                              onChanged: null,
                            );
                          } else {
                            return Checkbox(
                              value: snapshot.data,
                              onChanged: null,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
              ];
            },
          ),
        ],
      ),
      body: FutureBuilder<dynamic>(
          future: Future.wait<dynamic>([_todosFuture, _hideDoneTodos]),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasError) {
              return Center(
                child: Text(
                    "Oh no, something went wrong while loading the Todo list. :( reason: ${asyncSnapshot.error}"),
              );
            }

            if (asyncSnapshot.hasData) {
              List<Todo> items = (asyncSnapshot.data[0] as List<Todo>).toList();
              int itemCount = items.length;
              bool hideDoneTodos = asyncSnapshot.data[1] as bool;

              if (hideDoneTodos) {
                items.removeWhere((element) => element.isDone);
                itemCount = items.length;
              }

              return ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return TodoListItem(
                    items[index],
                    onTap: (todo) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              TodoDetails(_todosDataSource, todo.id)));
                    },
                    onDoneChanged: (todo, isDone) =>
                        onDoneChanged(todo, isDone),
                    onDeletePressed: (todo) => onDeletePressed(todo),
                  );
                },
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
        // ...
```

## Floor

### FloorTodo

```dart
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
```

### FloorTodoDao

```dart
import 'package:floor/floor.dart';

import 'floor_todo.dart';

@dao
abstract class FloorTodoDao {
  @Query('SELECT * FROM todo')
  Future<List<FloorTodo>> getAllTodos();

  @Query('SELECT * FROM todo WHERE id = :id')
  Future<FloorTodo> getTodo(int id);

  @Query("DELETE FROM todo WHERE id = :id")
  Future<void> deleteTodo(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> upsertTodo(FloorTodo todo);
}
```

### FloorTodoDatabase

```dart
import 'dart:async';

import 'package:awesome_todo_app/data/database/floor/floor_todo.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'floor_todo_dao.dart';

part 'floor_todo_database.g.dart';

@Database(
  version: 1,
  entities: [
    FloorTodo,
  ],
)
abstract class FloorTodoDatabase extends FloorDatabase {
  FloorTodoDao get todoDao;
}
```

### DataSource + Floor

```dart
import 'package:awesome_todo_app/data/database/floor/floor_todo.dart';
import 'package:awesome_todo_app/domain/model/todo_priority.dart';
import 'package:awesome_todo_app/util.dart';

import '../../domain/model/todo.dart';
import 'todo_repository.dart';

class DataSource {
  final TodoRepository<FloorTodo> database;

  DataSource(this.database);

  Future<void> init() async {
    await database.init();
  }

  Future<List<Todo>> getAllTodos() async {
    final todos = await database.getAllTodos();
    return todos
        .map(
          (floorTodo) => floorTodo.toTodo(),
        )
        .toList();
  }

  Future<Todo> getTodo(int id) async {
    final floorTodo = await database.getTodo(id);
    return floorTodo.toTodo();
  }

  Future<void> upsertTodo(Todo todo) async {
    return database.upsertTodo(todo.toFloorTodo());
  }

  Future<void> deleteTodo(Todo todo) async {
    return database.deleteTodo(todo.toFloorTodo());
  }

  Future<void> setTodoDone(Todo todo, bool isDone) async {
    return database.upsertTodo(todo.toFloorTodo()..isDone = isDone ? 1 : 0);
  }
}

extension TodoToFloorTodo on Todo {
  FloorTodo toFloorTodo() {
    return FloorTodo(
        id: this.id,
        title: this.title,
        description: this.description,
        priority: this.priority.index,
        isDone: this.isDone ? 1 : 0,
        dueDate: getFormattedDate(this.dueDate));
  }
}

extension FloorTodoToTodo on FloorTodo {
  Todo toTodo() {
    return Todo(
        id: this.id,
        title: this.title,
        description: this.description,
        priority: todoPriorityFromInt(this.priority),
        isDone: this.isDone == 1 ? true : false,
        dueDate: parseDate(this.dueDate));
  }
}
```

## Moor

### MoorTodo

```dart
import 'package:moor/moor.dart';

part 'moor_todo.g.dart';

class MoorTodo extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get dueDate => text()();

  BoolColumn get isDone => boolean()();

  TextColumn get description => text()();

  IntColumn get priority => integer()();
}

@UseMoor(tables: [MoorTodo])
class MoorTodoDatabase {
```

Run `flutter packages pub run build_runner watch`

### MoorTodo with extended database definition

```dart
import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'moor_todo.g.dart';

class MoorTodo extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get dueDate => text()();

  BoolColumn get isDone => boolean()();

  TextColumn get description => text()();

  IntColumn get priority => integer()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'moor_todo.db'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [MoorTodo])
class MoorTodoDatabase extends _$MoorTodoDatabase {
  MoorTodoDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
```

### MoorTodo with queries

```dart
import 'dart:io';
import 'dart:async';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'moor_todo.g.dart';

class MoorTodo extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get dueDate => text()();

  BoolColumn get isDone => boolean()();

  TextColumn get description => text()();

  IntColumn get priority => integer()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'moor_todo.db'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [MoorTodo])
class MoorTodoDatabase extends _$MoorTodoDatabase {
  MoorTodoDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<MoorTodoData>> getAllTodos() {
    return select(moorTodo).get();
  }

  Future<List<MoorTodoData>> getTodo(int id) {
    return (select(moorTodo)..limit(1)..where((todo) => todo.id.equals(id))).get();
  }

  Future<void> upsertTodo(MoorTodoData todo) {
    return into(moorTodo).insertOnConflictUpdate(todo);
  }

  Future<void> deleteTodo(MoorTodoData todo) {
    return (delete(moorTodo)..where((todoRow) => todoRow.id.equals(todo.id)))
        .go();
  }
}
```

### MoorTodoDao

```dart
// moor_todo.dart

@UseMoor(tables: [MoorTodo], daos: [MoorTodoDao])
class MoorTodoDatabase extends _$MoorTodoDatabase {
  MoorTodoDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

// moor_todo_dao.dart

import 'package:awesome_todo_app/data/database/moor/moor_todo.dart';
import 'package:moor/moor.dart';

part 'moor_todo_dao.g.dart';

@UseDao(tables: [MoorTodo])
class MoorTodoDao extends DatabaseAccessor<MoorTodoDatabase>
    with _$MoorTodoDaoMixin {
  MoorTodoDao(MoorTodoDatabase db) : super(db);

  Future<List<MoorTodoData>> getAllTodos() {
    return select(moorTodo).get();
  }

  Future<List<MoorTodoData>> getTodo(int id) {
    return (select(moorTodo)..limit(1)..where((todo) => todo.id.equals(id))).get();
  }

  Future<void> upsertTodo(MoorTodoData todo) {
    return into(moorTodo).insertOnConflictUpdate(todo);
  }

  Future<void> deleteTodo(MoorTodoData todo) {
    return (delete(moorTodo)..where((todoRow) => todoRow.id.equals(todo.id)))
        .go();
  }
}
```

### MoorTodoRepository

```dart
import 'package:awesome_todo_app/data/database/moor/moor_todo.dart';
import 'package:awesome_todo_app/data/database/moor/moor_todo_dao.dart';
import 'package:awesome_todo_app/data/database/todo_repository.dart';

class FloorTodoRepository implements TodoRepository<MoorTodoData> {
  MoorTodoDao todoDao;

  @override
  Future<void> init() async {
    final database = MoorTodoDatabase();
    todoDao = database.moorTodoDao;
  }

  @override
  Future<List<MoorTodoData>> getAllTodos() {
    return todoDao.getAllTodos();
  }

  @override
  Future<MoorTodoData> getTodo(int id) async {
    final todos = await todoDao.getTodo(id);
    return Future.value(todos.first);
  }

  @override
  Future<void> deleteTodo(MoorTodoData todo) {
    return todoDao.deleteTodo(todo);
  }

  @override
  Future<void> upsertTodo(MoorTodoData todo) {
    return todoDao.upsertTodo(todo);
  }
}
```

### DataSource + Moor

```dart
import 'package:awesome_todo_app/data/database/floor/floor_todo.dart';
import 'package:awesome_todo_app/domain/model/todo_priority.dart';
import 'package:awesome_todo_app/util.dart';

import '../../domain/model/todo.dart';
import 'moor/moor_todo.dart';
import 'todo_repository.dart';

class DataSource {
  final TodoRepository<MoorTodoData> database;

  DataSource(this.database);

  Future<void> init() async {
    await database.init();
  }

  Future<List<Todo>> getAllTodos() async {
    final todos = await database.getAllTodos();
    return todos
        .map(
          (moorTodo) => moorTodo.toTodo(),
        )
        .toList();
  }

  Future<Todo> getTodo(int id) async {
    final moorTodo = await database.getTodo(id);
    return moorTodo.toTodo();
  }

  Future<void> upsertTodo(Todo todo) async {
    return database.upsertTodo(todo.toMoorTodoData());
  }

  Future<void> deleteTodo(Todo todo) async {
    return database.deleteTodo(todo.toMoorTodoData());
  }

  Future<void> setTodoDone(Todo todo, bool isDone) async {
    return database.upsertTodo(
      todo.toMoorTodoData().copyWith(isDone: isDone),
    );
  }
}

extension TodoToFloorTodo on Todo {
  FloorTodo toFloorTodo() {
    return FloorTodo(
        id: this.id,
        title: this.title,
        description: this.description,
        priority: this.priority.index,
        isDone: this.isDone ? 1 : 0,
        dueDate: getFormattedDate(this.dueDate));
  }
}

// ...

extension TodoToMoorTodoData on Todo {
  MoorTodoData toMoorTodoData() {
    return MoorTodoData(
        id: this.id,
        title: this.title,
        description: this.description,
        priority: this.priority.index,
        isDone: this.isDone,
        dueDate: getFormattedDate(this.dueDate));
  }
}

extension MoorTodoDataToTodo on MoorTodoData {
  Todo toTodo() {
        return Todo(
        id: this.id,
        title: this.title,
        description: this.description,
        priority: todoPriorityFromInt(this.priority),
        isDone: this.isDone,
        dueDate: parseDate(this.dueDate));
  }
}
```

## Sembast

### SembastTodo

```dart
class SembastTodo {
  int id;
  String title;
  String dueDate;
  bool isDone;
  String description;
  int priority;

  SembastTodo({
    this.id,
    this.title,
    this.dueDate,
    this.isDone,
    this.description,
    this.priority,
  });

  factory SembastTodo.fromMap(int id, Map<String, dynamic> map) {
    return SembastTodo(
      id: id,
      title: map['title'],
      dueDate: map['dueDate'],
      isDone: map['isDone'],
      description: map['description'],
      priority: map['priority'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'dueDate': this.dueDate,
      'isDone': this.isDone,
      'description': this.description,
      'priority': this.priority,
    };
  }
}
```

### SembastTodoRepository

```dart
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
```

### DataSource + Sembast

```dart
import 'package:awesome_todo_app/data/database/floor/floor_todo.dart';
import 'package:awesome_todo_app/data/database/sembast/sembast_todo.dart';
import 'package:awesome_todo_app/domain/model/todo_priority.dart';
import 'package:awesome_todo_app/util.dart';

import '../../domain/model/todo.dart';
import 'moor/moor_todo.dart';
import 'todo_repository.dart';

class DataSource {
  final TodoRepository<SembastTodo> database;

  DataSource(this.database);

  Future<void> init() async {
    await database.init();
  }

  Future<List<Todo>> getAllTodos() async {
    final todos = await database.getAllTodos();
    return todos
        .map(
          (moorTodo) => moorTodo.toTodo(),
        )
        .toList();
  }

  Future<Todo> getTodo(int id) async {
    final moorTodo = await database.getTodo(id);
    return moorTodo.toTodo();
  }

  Future<void> upsertTodo(Todo todo) async {
    return database.upsertTodo(todo.toSembastTodo());
  }

  Future<void> deleteTodo(Todo todo) async {
    return database.deleteTodo(todo.toSembastTodo());
  }

  Future<void> setTodoDone(Todo todo, bool isDone) async {
    return database.upsertTodo(todo.toSembastTodo()..isDone = isDone);
  }
}

// ...

extension TodoToSembastTodo on Todo {
  SembastTodo toSembastTodo() {
    return SembastTodo(
      id: this.id,
      title: this.title,
      description: this.description,
      priority: this.priority.index,
      isDone: this.isDone,
      dueDate: getFormattedDate(this.dueDate),
    );
  }
}

extension SembastTodoToTodo on SembastTodo {
  Todo toTodo() {
    return Todo(
      id: this.id,
      title: this.title,
      description: this.description,
      priority: todoPriorityFromInt(this.priority),
      isDone: this.isDone,
      dueDate: parseDate(this.dueDate),
    );
  }
}
```

## Hive

### HiveTodo

```dart
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
```

### HiveTodoRepository

```dart
import 'package:awesome_todo_app/data/database/todo_repository.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'hive_todo.dart';

class HiveTodoRepository implements TodoRepository<HiveTodo> {
  static const HIVE_TODO_BOX = 'hive_todo';

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HiveTodoAdapter());
  }

  @override
  Future<List<HiveTodo>> getAllTodos() async {
    List<HiveTodo> todos;
    await withHiveTodoBox((box) async {
      todos = box.values.toList() ?? [];
    });
    return Future.value(todos);
  }

  @override
  Future<HiveTodo> getTodo(int id) async {
    HiveTodo hiveTodo;
    await withHiveTodoBox((box) async {
      hiveTodo = box.get(id);
    });
    return hiveTodo;
  }

  @override
  Future<void> deleteTodo(HiveTodo todo) async {
    return await withHiveTodoBox((box) async {
      await box.delete(todo.id);
    });
  }

  @override
  Future<void> upsertTodo(HiveTodo todo) async {
    return await withHiveTodoBox((box) async {
      if (todo.id == null) {
        final id = await box.add(todo);
        todo.id = id;
        todo.save();
      } else {
        await box.put(todo.key, todo);
      }
    });
  }

  Future<void> withHiveTodoBox(Future<void> Function(Box<HiveTodo> box) task) async {
    final box = await Hive.openBox<HiveTodo>(HIVE_TODO_BOX);
    await task(box);
    await box.close();
  }
}
```

### DataSource + Hive

```dart
import 'package:awesome_todo_app/data/database/floor/floor_todo.dart';
import 'package:awesome_todo_app/data/database/hive/hive_todo.dart';
import 'package:awesome_todo_app/data/database/sembast/sembast_todo.dart';
import 'package:awesome_todo_app/domain/model/todo_priority.dart';
import 'package:awesome_todo_app/util.dart';

import '../../domain/model/todo.dart';
import 'moor/moor_todo.dart';
import 'todo_repository.dart';

class DataSource {
  final TodoRepository<HiveTodo> database;

  DataSource(this.database);

  Future<void> init() async {
    await database.init();
  }

  Future<List<Todo>> getAllTodos() async {
    final todos = await database.getAllTodos();
    return todos
        .map(
          (hiveTodo) => hiveTodo.toTodo(),
        )
        .toList();
  }

  Future<Todo> getTodo(int id) async {
    final hiveTodo = await database.getTodo(id);
    return hiveTodo.toTodo();
  }

  Future<void> upsertTodo(Todo todo) async {
    return database.upsertTodo(todo.toHiveTodo());
  }

  Future<void> deleteTodo(Todo todo) async {
    return database.deleteTodo(todo.toHiveTodo());
  }

  Future<void> setTodoDone(Todo todo, bool isDone) async {
    return database.upsertTodo(todo.toHiveTodo()..isDone = isDone);
  }
}

// ...

extension TodoToHiveTodo on Todo {
  HiveTodo toHiveTodo() {
    return HiveTodo(
      id: this.id,
      title: this.title,
      description: this.description,
      priority: this.priority.index,
      isDone: this.isDone,
      dueDate: this.dueDate,
    );
  }
}

extension HiveTodoToTodo on HiveTodo {
  Todo toTodo() {
    return Todo(
      id: this.id,
      title: this.title,
      description: this.description,
      priority: todoPriorityFromInt(this.priority),
      isDone: this.isDone,
      dueDate: this.dueDate,
    );
  }
}
```

