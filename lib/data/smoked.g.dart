// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smoked.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SmokedAdapter extends TypeAdapter<Smoked> {
  @override
  final int typeId = 1;

  @override
  Smoked read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Smoked(
      somkedtoday: fields[0] as int,
      spenttoday: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Smoked obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.somkedtoday)
      ..writeByte(1)
      ..write(obj.spenttoday);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmokedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
