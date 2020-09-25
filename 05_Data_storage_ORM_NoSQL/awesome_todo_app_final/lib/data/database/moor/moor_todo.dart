import 'dart:io';
import 'dart:async';

import 'package:awesome_todo_app/data/database/moor/moor_todo_dao.dart';
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

@UseMoor(tables: [MoorTodo], daos: [MoorTodoDao])
class MoorTodoDatabase extends _$MoorTodoDatabase {
  MoorTodoDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
