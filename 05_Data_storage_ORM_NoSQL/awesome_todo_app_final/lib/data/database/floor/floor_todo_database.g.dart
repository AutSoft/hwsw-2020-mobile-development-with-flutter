// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_todo_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorFloorTodoDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorTodoDatabaseBuilder databaseBuilder(String name) =>
      _$FloorTodoDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorTodoDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FloorTodoDatabaseBuilder(null);
}

class _$FloorTodoDatabaseBuilder {
  _$FloorTodoDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$FloorTodoDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FloorTodoDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FloorTodoDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$FloorTodoDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FloorTodoDatabase extends FloorTodoDatabase {
  _$FloorTodoDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FloorTodoDao _todoDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `todo` (`id` INTEGER, `title` TEXT, `dueDate` TEXT, `isDone` INTEGER, `description` TEXT, `priority` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FloorTodoDao get todoDao {
    return _todoDaoInstance ??= _$FloorTodoDao(database, changeListener);
  }
}

class _$FloorTodoDao extends FloorTodoDao {
  _$FloorTodoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _floorTodoUpdateAdapter = UpdateAdapter(
            database,
            'todo',
            ['id'],
            (FloorTodo item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'dueDate': item.dueDate,
                  'isDone': item.isDone == null ? null : (item.isDone ? 1 : 0),
                  'description': item.description,
                  'priority': item.priority
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _todoMapper = (Map<String, dynamic> row) => FloorTodo(
      id: row['id'] as int,
      title: row['title'] as String,
      dueDate: row['dueDate'] as String,
      isDone: row['isDone'] == null ? null : (row['isDone'] as int) != 0,
      description: row['description'] as String,
      priority: row['priority'] as int);

  final UpdateAdapter<FloorTodo> _floorTodoUpdateAdapter;

  @override
  Future<List<FloorTodo>> getAllTodos() async {
    return _queryAdapter.queryList('SELECT * FROM todo', mapper: _todoMapper);
  }

  @override
  Future<FloorTodo> getTodo(int id) async {
    return _queryAdapter.query('SELECT * FROM todo WHERE id = ?',
        arguments: <dynamic>[id], mapper: _todoMapper);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM todo WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> upsertTodo(FloorTodo todo) async {
    await _floorTodoUpdateAdapter.update(todo, OnConflictStrategy.replace);
  }
}
