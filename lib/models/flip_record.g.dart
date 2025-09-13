// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flip_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlipRecordAdapter extends TypeAdapter<FlipRecord> {
  @override
  final int typeId = 0;

  @override
  FlipRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlipRecord(
      date: fields[0] as DateTime,
      amount: fields[1] as double,
      motivationalMessage: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FlipRecord obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.motivationalMessage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlipRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
