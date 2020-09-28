// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_todo.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class MoorTodoData extends DataClass implements Insertable<MoorTodoData> {
  final int id;
  final String title;
  final String dueDate;
  final bool isDone;
  final String description;
  final int priority;
  MoorTodoData(
      {@required this.id,
      @required this.title,
      @required this.dueDate,
      @required this.isDone,
      @required this.description,
      @required this.priority});
  factory MoorTodoData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return MoorTodoData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      dueDate: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}due_date']),
      isDone:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_done']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      priority:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}priority']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<String>(dueDate);
    }
    if (!nullToAbsent || isDone != null) {
      map['is_done'] = Variable<bool>(isDone);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || priority != null) {
      map['priority'] = Variable<int>(priority);
    }
    return map;
  }

  MoorTodoCompanion toCompanion(bool nullToAbsent) {
    return MoorTodoCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      isDone:
          isDone == null && nullToAbsent ? const Value.absent() : Value(isDone),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      priority: priority == null && nullToAbsent
          ? const Value.absent()
          : Value(priority),
    );
  }

  factory MoorTodoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorTodoData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      dueDate: serializer.fromJson<String>(json['dueDate']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      description: serializer.fromJson<String>(json['description']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'dueDate': serializer.toJson<String>(dueDate),
      'isDone': serializer.toJson<bool>(isDone),
      'description': serializer.toJson<String>(description),
      'priority': serializer.toJson<int>(priority),
    };
  }

  MoorTodoData copyWith(
          {int id,
          String title,
          String dueDate,
          bool isDone,
          String description,
          int priority}) =>
      MoorTodoData(
        id: id ?? this.id,
        title: title ?? this.title,
        dueDate: dueDate ?? this.dueDate,
        isDone: isDone ?? this.isDone,
        description: description ?? this.description,
        priority: priority ?? this.priority,
      );
  @override
  String toString() {
    return (StringBuffer('MoorTodoData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dueDate: $dueDate, ')
          ..write('isDone: $isDone, ')
          ..write('description: $description, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              dueDate.hashCode,
              $mrjc(isDone.hashCode,
                  $mrjc(description.hashCode, priority.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MoorTodoData &&
          other.id == this.id &&
          other.title == this.title &&
          other.dueDate == this.dueDate &&
          other.isDone == this.isDone &&
          other.description == this.description &&
          other.priority == this.priority);
}

class MoorTodoCompanion extends UpdateCompanion<MoorTodoData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> dueDate;
  final Value<bool> isDone;
  final Value<String> description;
  final Value<int> priority;
  const MoorTodoCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.isDone = const Value.absent(),
    this.description = const Value.absent(),
    this.priority = const Value.absent(),
  });
  MoorTodoCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    @required String dueDate,
    @required bool isDone,
    @required String description,
    @required int priority,
  })  : title = Value(title),
        dueDate = Value(dueDate),
        isDone = Value(isDone),
        description = Value(description),
        priority = Value(priority);
  static Insertable<MoorTodoData> custom({
    Expression<int> id,
    Expression<String> title,
    Expression<String> dueDate,
    Expression<bool> isDone,
    Expression<String> description,
    Expression<int> priority,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (dueDate != null) 'due_date': dueDate,
      if (isDone != null) 'is_done': isDone,
      if (description != null) 'description': description,
      if (priority != null) 'priority': priority,
    });
  }

  MoorTodoCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<String> dueDate,
      Value<bool> isDone,
      Value<String> description,
      Value<int> priority}) {
    return MoorTodoCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      isDone: isDone ?? this.isDone,
      description: description ?? this.description,
      priority: priority ?? this.priority,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<String>(dueDate.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoorTodoCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dueDate: $dueDate, ')
          ..write('isDone: $isDone, ')
          ..write('description: $description, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }
}

class $MoorTodoTable extends MoorTodo
    with TableInfo<$MoorTodoTable, MoorTodoData> {
  final GeneratedDatabase _db;
  final String _alias;
  $MoorTodoTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dueDateMeta = const VerificationMeta('dueDate');
  GeneratedTextColumn _dueDate;
  @override
  GeneratedTextColumn get dueDate => _dueDate ??= _constructDueDate();
  GeneratedTextColumn _constructDueDate() {
    return GeneratedTextColumn(
      'due_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  GeneratedBoolColumn _isDone;
  @override
  GeneratedBoolColumn get isDone => _isDone ??= _constructIsDone();
  GeneratedBoolColumn _constructIsDone() {
    return GeneratedBoolColumn(
      'is_done',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _priorityMeta = const VerificationMeta('priority');
  GeneratedIntColumn _priority;
  @override
  GeneratedIntColumn get priority => _priority ??= _constructPriority();
  GeneratedIntColumn _constructPriority() {
    return GeneratedIntColumn(
      'priority',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, dueDate, isDone, description, priority];
  @override
  $MoorTodoTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'moor_todo';
  @override
  final String actualTableName = 'moor_todo';
  @override
  VerificationContext validateIntegrity(Insertable<MoorTodoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date'], _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done'], _isDoneMeta));
    } else if (isInserting) {
      context.missing(_isDoneMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority'], _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoorTodoData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MoorTodoData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MoorTodoTable createAlias(String alias) {
    return $MoorTodoTable(_db, alias);
  }
}

abstract class _$MoorTodoDatabase extends GeneratedDatabase {
  _$MoorTodoDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $MoorTodoTable _moorTodo;
  $MoorTodoTable get moorTodo => _moorTodo ??= $MoorTodoTable(this);
  MoorTodoDao _moorTodoDao;
  MoorTodoDao get moorTodoDao =>
      _moorTodoDao ??= MoorTodoDao(this as MoorTodoDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [moorTodo];
}
