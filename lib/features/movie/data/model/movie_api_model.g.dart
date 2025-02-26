// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieApiModel _$MovieApiModelFromJson(Map<String, dynamic> json) =>
    MovieApiModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      releaseDate: json['releaseDate'] as String,
      durationMin: (json['duration_min'] as num).toInt(),
      language: json['language'] as String,
      posterUrl: PosterUrl.fromJson(json['posterURL'] as Map<String, dynamic>),
      trailerUrl: json['trailerURL'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$MovieApiModelToJson(MovieApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'description': instance.description,
      'releaseDate': instance.releaseDate,
      'duration_min': instance.durationMin,
      'language': instance.language,
      'posterURL': instance.posterUrl,
      'trailerURL': instance.trailerUrl,
      'status': instance.status,
    };

PosterUrl _$PosterUrlFromJson(Map<String, dynamic> json) => PosterUrl(
      sm: json['sm'] as String,
      lg: json['lg'] as String,
    );

Map<String, dynamic> _$PosterUrlToJson(PosterUrl instance) => <String, dynamic>{
      'sm': instance.sm,
      'lg': instance.lg,
    };
