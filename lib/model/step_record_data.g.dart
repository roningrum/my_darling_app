// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_record_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StepRecordDataAdapter extends TypeAdapter<StepRecordData> {
  @override
  final int typeId = 0;

  @override
  StepRecordData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StepRecordData()
      ..steps = fields[1] as int
      ..cal = fields[2] as double
      ..timeStamp = fields[3] as DateTime;
  }

  @override
  void write(BinaryWriter writer, StepRecordData obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.steps)
      ..writeByte(2)
      ..write(obj.cal)
      ..writeByte(3)
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepRecordDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
