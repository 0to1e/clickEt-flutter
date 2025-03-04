import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String id;
  final String name;
  final String category;
  final String description;
  final String releaseDate;
  final int durationMin;
  final String language;
  final String posterSmallUrl;
  final String posterLargeUrl;
  final String trailerUrl;
  final String status;

  const MovieEntity({
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