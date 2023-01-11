// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_users.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DBUserAdapter extends TypeAdapter<DBUser> {
  @override
  final int typeId = 0;

  @override
  DBUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DBUser(
      id: fields[0] as String,
      name: fields[1] as String,
      password: fields[2] as String,
      status: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DBUser obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DBUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
