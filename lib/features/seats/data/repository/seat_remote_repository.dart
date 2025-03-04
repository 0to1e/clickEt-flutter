import 'package:ClickEt/features/seats/data/data_source/seat_data_source.dart';
import 'package:ClickEt/features/seats/domain/entity/seat_entity.dart';
import 'package:ClickEt/features/seats/domain/repository/seat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:ClickEt/core/error/failure.dart';


class SeatRemoteRepository implements ISeatRepository {
  final ISeatDataSource remoteDataSource;

  const SeatRemoteRepository(this.remoteDataSource);

  @override
  Future<Either<Failure, SeatLayoutEntity>> getSeatLayout(String screeningId) {
    return remoteDataSource.getSeatLayout(screeningId);
  }

  @override
  Future<Either<Failure, HoldResponseEntity>> holdSeats(String screeningId, List<SeatPosition> seats) {
    return remoteDataSource.holdSeats(screeningId, seats);
  }

  @override
  Future<Either<Failure, void>> releaseHold(String holdId) {
    return remoteDataSource.releaseHold(holdId);
  }

  @override
  Future<Either<Failure, BookingResponseEntity>> confirmBooking(String holdId) {
    return remoteDataSource.confirmBooking(holdId);
  }
}