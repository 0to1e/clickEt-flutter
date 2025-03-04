import 'package:ClickEt/features/screenig/domain/entity/screening_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:ClickEt/core/error/failure.dart';

abstract class IScreeningRepository {
  Future<Either<Failure, List<ScreeningEntity>>> getScreeningsByMovie(
      String movieId);
}