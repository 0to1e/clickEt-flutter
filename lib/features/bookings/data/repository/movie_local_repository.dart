import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/features/movie/data/data_source/local_data_source/movie_local_data_source.dart';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:dartz/dartz.dart';

class LocalMovieRepository {
  final LocalMovieDataSource _localDataSource;

  LocalMovieRepository(this._localDataSource);

  Future<Either<Failure, List<MovieEntity>>> getShowingMovies() async {
    try {
      final movies = await _localDataSource.getCachedShowingMovies();
      return Right(movies);
    } catch (e) {
      return const Left(LocalDatabaseFailure(
          message: "Failed to fetch cached showing movies"));
    }
  }

  Future<Either<Failure, List<MovieEntity>>> getUpcomingMovies() async {
    try {
      final movies = await _localDataSource.getCachedUpcomingMovies();
      return Right(movies);
    } catch (e) {
      return const Left(LocalDatabaseFailure(
          message: "Failed to fetch cached upcoming movies"));
    }
  }

  Future<Either<Failure, void>> cacheMovies(List<MovieEntity> movies) async {
    try {
      await _localDataSource.cacheMovies(movies);
      return const Right(null);
    } catch (e) {
      return const Left(
          LocalDatabaseFailure(message: "Failed to cache movies"));
    }
  }
}
