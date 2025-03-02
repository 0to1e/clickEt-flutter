import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_api_model.g.dart';

@JsonSerializable()
class MovieApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String category;
  final String description;
  final String releaseDate;
  @JsonKey(name: 'duration_min')
  final int durationMin;
  final String language;
  @JsonKey(name: 'posterURL')
  final PosterUrl posterUrl;
  @JsonKey(name: 'trailerURL')
  final String trailerUrl;
  final String status;

  const MovieApiModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.releaseDate,
    required this.durationMin,
    required this.language,
    required this.posterUrl,
    required this.trailerUrl,
    required this.status,
  });

  factory MovieApiModel.fromJson(Map<String, dynamic> json) => _$MovieApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieApiModelToJson(this);

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      name: name,
      category: category,
      description: description,
      releaseDate: releaseDate,
      durationMin: durationMin,
      language: language,
      posterSmallUrl: posterUrl.sm,
      posterLargeUrl: posterUrl.lg,
      trailerUrl: trailerUrl,
      status: status,
    );
  }

  factory MovieApiModel.fromEntity(MovieEntity entity) {
    return MovieApiModel(
      id: entity.id,
      name: entity.name,
      category: entity.category,
      description: entity.description,
      releaseDate: entity.releaseDate,
      durationMin: entity.durationMin,
      language: entity.language,
      posterUrl: PosterUrl(sm: entity.posterSmallUrl, lg: entity.posterLargeUrl),
      trailerUrl: entity.trailerUrl,
      status: entity.status,
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
        posterUrl,
        trailerUrl,
        status,
      ];
}

@JsonSerializable()
class PosterUrl extends Equatable {
  final String sm;
  final String lg;

  const PosterUrl({required this.sm, required this.lg});

  factory PosterUrl.fromJson(Map<String, dynamic> json) => _$PosterUrlFromJson(json);

  Map<String, dynamic> toJson() => _$PosterUrlToJson(this);

  @override
  List<Object> get props => [sm, lg];
}