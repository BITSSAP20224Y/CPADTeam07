// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attempt.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttemptAdapter extends TypeAdapter<Attempt> {
  @override
  final int typeId = 0;

  @override
  Attempt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Attempt(
      questEmoji: fields[0] as String,
      questName: fields[1] as String,
      mediaPath: fields[2] as String,
      mediaType: fields[3] as String,
      success: fields[4] as bool,
      timestamp: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Attempt obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.questEmoji)
      ..writeByte(1)
      ..write(obj.questName)
      ..writeByte(2)
      ..write(obj.mediaPath)
      ..writeByte(3)
      ..write(obj.mediaType)
      ..writeByte(4)
      ..write(obj.success)
      ..writeByte(5)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttemptAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
