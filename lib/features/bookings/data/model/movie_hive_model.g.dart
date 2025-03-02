// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieHiveModelAdapter extends TypeAdapter<MovieHiveModel> {
  @override
  final int typeId = 1;

  @override
  MovieHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieHiveModel(
      id: fields[0] as String,
      name: fields[1] as String,
      category: fields[2] as String,
      description: fields[3] as String,
      releaseDate: fields[4] as String,
      durationMin: fields[5] as int,
      language: fields[6] as String,
      posterSmallUrl: fields[7] as String,
      posterLargeUrl: fields[8] as String,
      trailerUrl: fields[9] as String,
      status: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MovieHiveModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.releaseDate)
      ..writeByte(5)
      ..write(obj.durationMin)
      ..writeByte(6)
      ..write(obj.language)
      ..writeByte(7)
      ..write(obj.posterSmallUrl)
      ..writeByte(8)
      ..write(obj.posterLargeUrl)
      ..writeByte(9)
      ..write(obj.trailerUrl)
      ..writeByte(10)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
