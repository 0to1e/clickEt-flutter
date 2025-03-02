import 'package:ClickEt/app/usecase/usecase.dart';
import 'package:ClickEt/features/screenig/domain/entity/screening_entity.dart';
import 'package:ClickEt/features/screenig/domain/repository/screening_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:ClickEt/core/error/failure.dart';
import 'package:equatable/equatable.dart';

class GetScreeningsByMovieParams extends Equatable {
  final String movieId;

  const GetScreeningsByMovieParams({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

class GetScreeningsByMovieUseCase
    implements
        UsecaseWithParams<List<ScreeningEntity>, GetScreeningsByMovieParams> {
  final IScreeningRepository repository;

  GetScreeningsByMovieUseCase(this.repository);

  @override
  Future<Either<Failure, List<ScreeningEntity>>> call(
      GetScreeningsByMovieParams params) {
    return repository.getScreeningsByMovie(params.movieId);
  }
}
