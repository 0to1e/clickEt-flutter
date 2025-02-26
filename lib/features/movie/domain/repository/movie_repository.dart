import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:dartz/dartz.dart';


abstract class IMovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getShowingMovies();
  Future<Either<Failure, List<MovieEntity>>> getUpcomingMovies();
}