// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArtAdapter extends TypeAdapter<Art> {
  @override
  final int typeId = 1;

  @override
  Art read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Art(
      artName: fields[0] as String,
      urlImg: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Art obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.artName)
      ..writeByte(1)
      ..write(obj.urlImg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
