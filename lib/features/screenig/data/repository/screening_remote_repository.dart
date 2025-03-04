import 'package:ClickEt/features/screenig/data/data_source/remote_data_source/screening_remote_data_source.dart';
import 'package:ClickEt/features/screenig/domain/entity/screening_entity.dart';
import 'package:ClickEt/features/screenig/domain/repository/screening_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:ClickEt/core/error/failure.dart';

class ScreeningRemoteRepository implements IScreeningRepository {
  final ScreeningRemoteDataSource _remoteDataSource;

  ScreeningRemoteRepository(this._remoteDataSource);

  @override
  Future<Either<Failure, List<ScreeningEntity>>> getScreeningsByMovie(
      String movieId) {
    return _remoteDataSource.getScreeningsByMovie(movieId);
  }
}