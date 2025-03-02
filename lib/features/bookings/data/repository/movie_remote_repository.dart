import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/features/movie/data/data_source/remote_data_source/movie_remote_data_source.dart';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:dartz/dartz.dart';

class RemoteMovieRepository {
  final RemoteMovieDataSource _remoteDataSource;

  RemoteMovieRepository(this._remoteDataSource);

  Future<Either<Failure, List<MovieEntity>>> getShowingMovies() async {
    try {
      final result = await _remoteDataSource.getShowingMovies();
      return result.fold(
        (failure) => Left(failure),
        (movies) => Right(movies),
      );
    } catch (e) {
      return Left(ApiFailure(message: "Failed to fetch showing movies: $e"));
    }
  }

  Future<Either<Failure, List<MovieEntity>>> getUpcomingMovies() async {
    try {
      final result = await _remoteDataSource.getUpcomingMovies();
      return result.fold(
        (failure) => Left(failure),
        (movies) => Right(movies),
      );
    } catch (e) {
      return Left(ApiFailure(message: "Failed to fetch upcoming movies: $e"));
    }
  }
}