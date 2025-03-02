import 'package:dartz/dartz.dart';
import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/app/usecase/usecase.dart';
// ^ Adjust this import path if your "UsecaseWithParams" is defined elsewhere

import 'package:ClickEt/features/movie/data/data_source/local_data_source/movie_local_data_source.dart';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';

import 'package:equatable/equatable.dart';

class CacheMoviesParams extends Equatable {
  final List<MovieEntity> movies;

  const CacheMoviesParams({required this.movies});

  @override
  List<Object?> get props => [movies];
}

class CacheMoviesUseCase implements UsecaseWithParams<void, CacheMoviesParams> {
  final LocalMovieDataSource localDataSource;

  CacheMoviesUseCase(this.localDataSource);

  @override
  Future<Either<Failure, void>> call(CacheMoviesParams params) async {
    try {
      // Attempt to cache the new movies in Hive
      await localDataSource.cacheMovies(params.movies);
      return const Right(null);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(message: 'Failed to cache movies: $e'),
      );
    }
  }

  /// Retrieve all "showing" cached movies
  Future<List<MovieEntity>> getCachedShowingMovies() {
    return localDataSource.getCachedShowingMovies();
  }

  /// Retrieve all "upcoming" cached movies
  Future<List<MovieEntity>> getCachedUpcomingMovies() {
    return localDataSource.getCachedUpcomingMovies();
  }
}
