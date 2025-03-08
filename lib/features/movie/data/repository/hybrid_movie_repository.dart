import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/features/movie/data/repository/movie_local_repository.dart';
import 'package:ClickEt/features/movie/data/repository/movie_remote_repository.dart';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:ClickEt/features/movie/domain/repository/movie_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class MovieRepository implements IMovieRepository {
  final RemoteMovieRepository _remoteRepository;
  final LocalMovieRepository _localRepository;
  final Connectivity _connectivity;

  MovieRepository(
      this._remoteRepository, this._localRepository, this._connectivity);

  Future<Either<Failure, List<MovieEntity>>> _fetchMovies({
    required Future<Either<Failure, List<MovieEntity>>> Function() remoteFetch,
    required Future<Either<Failure, List<MovieEntity>>> Function() localFetch,
    required Future<Either<Failure, void>> Function(List<MovieEntity>)
        cacheMovies,
  }) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      final result = await remoteFetch();
      result.fold(
        (failure) {
          debugPrint("Remote fetch failed: ${failure.message}");
        },
        (movies) {
          cacheMovies(movies);
        },
      );
      return result;
    } else {
      return localFetch();
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getShowingMovies() {
    return _fetchMovies(
      remoteFetch: _remoteRepository.getShowingMovies,
      localFetch: _localRepository.getShowingMovies,
      cacheMovies: _localRepository.cacheMovies,
    );
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getUpcomingMovies() {
    return _fetchMovies(
      remoteFetch: _remoteRepository.getUpcomingMovies,
      localFetch: _localRepository.getUpcomingMovies,
      cacheMovies: _localRepository.cacheMovies,
    );
  }
}
