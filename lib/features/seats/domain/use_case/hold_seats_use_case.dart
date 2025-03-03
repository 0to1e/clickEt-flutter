import 'package:ClickEt/features/seats/domain/entity/seat_entity.dart';
import 'package:ClickEt/features/seats/domain/repository/seat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:ClickEt/core/error/failure.dart';

class HoldSeatsUseCase {
  final ISeatRepository repository;

  const HoldSeatsUseCase(this.repository);

  Future<Either<Failure, HoldResponseEntity>> call(String screeningId, List<SeatPosition> seats) {
    return repository.holdSeats(screeningId, seats);
  }
}