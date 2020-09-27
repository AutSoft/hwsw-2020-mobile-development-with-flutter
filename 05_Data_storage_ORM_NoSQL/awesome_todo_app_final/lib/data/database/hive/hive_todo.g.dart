// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveTodoAdapter extends TypeAdapter<HiveTodo> {
  @override
  final int typeId = 0;

  @override
  HiveTodo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveTodo(
      id: fields[0] as int,
      title: fields[1] as String,
      dueDate: fields[2] as DateTime,
      isDone: fields[3] as bool,
      description: fields[4] as String,
      priority: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveTodo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.dueDate)
      ..writeByte(3)
      ..write(obj.isDone)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.priority);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveTodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
