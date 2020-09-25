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
