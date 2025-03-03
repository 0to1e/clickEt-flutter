import 'package:ClickEt/features/seats/domain/entity/seat_entity.dart';
import 'package:ClickEt/features/seats/domain/repository/seat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:ClickEt/core/error/failure.dart';


class ConfirmBookingUseCase {
  final ISeatRepository repository;

  const ConfirmBookingUseCase(this.repository);

  Future<Either<Failure, BookingResponseEntity>> call(String holdId) {
    return repository.confirmBooking(holdId);
  }
}