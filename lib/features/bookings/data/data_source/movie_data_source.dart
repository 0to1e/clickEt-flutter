import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';

abstract interface class IMovieDataSource {
  Future<List<MovieEntity>> getShowingMovies();
  Future<List<MovieEntity>> getUpcomingMovies();
  Future<void> cacheMovies(List<MovieEntity> movies);
  Future <List<MovieEntity>> getCachedShowingMovies();
  Future<List<MovieEntity>> getCachedUpcomingMovies();
}