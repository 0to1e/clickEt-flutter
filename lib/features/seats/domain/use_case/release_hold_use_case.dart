import 'package:ClickEt/features/seats/domain/repository/seat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:ClickEt/core/error/failure.dart';

class ReleaseHoldUseCase {
  final ISeatRepository repository;

  const ReleaseHoldUseCase(this.repository);

  Future<Either<Failure, void>> call(String holdId) {
    return repository.releaseHold(holdId);
  }
}