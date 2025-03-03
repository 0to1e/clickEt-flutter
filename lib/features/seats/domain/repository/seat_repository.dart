import 'package:ClickEt/features/seats/domain/entity/seat_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:ClickEt/core/error/failure.dart';

abstract class ISeatRepository {
  Future<Either<Failure, SeatLayoutEntity>> getSeatLayout(String screeningId);
  Future<Either<Failure, HoldResponseEntity>> holdSeats(String screeningId, List<SeatPosition> seats);
  Future<Either<Failure, void>> releaseHold(String holdId);
  Future<Either<Failure, BookingResponseEntity>> confirmBooking(String holdId);
}