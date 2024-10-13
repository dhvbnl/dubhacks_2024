// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'still.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StillAdapter extends TypeAdapter<Still> {
  @override
  final int typeId = 0;

  @override
  Still read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Still(
      id: fields[0] as String,
      prompt: fields[1] as String,
      date: fields[2] as DateTime,
      photo: fields[3] as AssetImage,
    );
  }

  @override
  void write(BinaryWriter writer, Still obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.prompt)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StillAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
