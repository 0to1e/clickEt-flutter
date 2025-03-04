import 'package:ClickEt/app/constants/hive_table_constant.dart';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'movie_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.movieTableId)
class MovieHiveModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String releaseDate;
  @HiveField(5)
  final int durationMin;
  @HiveField(6)
  final String language;
  @HiveField(7)
  final String posterSmallUrl;
  @HiveField(8)
  final String posterLargeUrl;
  @HiveField(9)
  final String trailerUrl;
  @HiveField(10)
  final String status;

  const MovieHiveModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.releaseDate,
    required this.durationMin,
    required this.language,
    required this.posterSmallUrl,
    required this.posterLargeUrl,
    required this.trailerUrl,
    required this.status,
  });

  factory MovieHiveModel.fromEntity(MovieEntity entity) {
    return MovieHiveModel(
      id: entity.id,
      name: entity.name,
      category: entity.category,
      description: entity.description,
      releaseDate: entity.releaseDate,
      durationMin: entity.durationMin,
      language: entity.language,
      posterSmallUrl: entity.posterSmallUrl,
      posterLargeUrl: entity.posterLargeUrl,
      trailerUrl: entity.trailerUrl,
      status: entity.status,
    );
  }

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      name: name,
      category: category,
      description: description,
      releaseDate: releaseDate,
      durationMin: durationMin,
      language: language,
      posterSmallUrl: posterSmallUrl,
      posterLargeUrl: posterLargeUrl,
      trailerUrl: trailerUrl,
      status: status,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        category,
        description,
        releaseDate,
        durationMin,
        language,
        posterSmallUrl,
        posterLargeUrl,
        trailerUrl,
        status,
      ];
}
