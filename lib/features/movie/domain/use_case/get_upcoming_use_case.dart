import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/features/movie/data/repository/hybrid_movie_repository.dart';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:dartz/dartz.dart';

class GetUpcomingMoviesUseCase {
  final MovieRepository repository;

  GetUpcomingMoviesUseCase(this.repository);

  Future<Either<Failure, List<MovieEntity>>> call() {
    return repository.getUpcomingMovies();
  }
}