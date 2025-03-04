import 'package:ClickEt/features/seats/domain/entity/seat_entity.dart';
import 'package:ClickEt/features/seats/domain/repository/seat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:ClickEt/core/error/failure.dart';


class GetSeatLayoutUseCase {
  final ISeatRepository repository;

  const GetSeatLayoutUseCase(this.repository);

  Future<Either<Failure, SeatLayoutEntity>> call(String screeningId) {
    return repository.getSeatLayout(screeningId);
  }
}