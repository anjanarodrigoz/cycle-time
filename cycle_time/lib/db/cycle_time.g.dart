// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/cycle_time.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CycleTimeAdapter extends TypeAdapter<CycleTime> {
  @override
  final int typeId = 1;

  @override
  CycleTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CycleTime(
      start: fields[0] as Duration,
      loading: fields[1] as Duration,
      uphill: fields[2] as Duration,
      dumping: fields[3] as Duration,
      downhill: fields[4] as Duration,
      cycle: fields[5] as Duration,
      startTime: fields[6] as DateTime,
      endTime: fields[7] as DateTime,
      index: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CycleTime obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.start)
      ..writeByte(1)
      ..write(obj.loading)
      ..writeByte(2)
      ..write(obj.uphill)
      ..writeByte(3)
      ..write(obj.dumping)
      ..writeByte(4)
      ..write(obj.downhill)
      ..writeByte(5)
      ..write(obj.cycle)
      ..writeByte(6)
      ..write(obj.startTime)
      ..writeByte(7)
      ..write(obj.endTime)
      ..writeByte(8)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CycleTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
