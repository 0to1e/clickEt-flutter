// lib/features/booking/domain/use_case/get_booking_history_use_case.dart
import 'package:ClickEt/features/bookings/data/repository/booking_remote_repository.dart';
import 'package:ClickEt/features/bookings/domain/entity/booking_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:ClickEt/core/error/failure.dart';


class GetBookingHistoryUseCase {
  final BookingRepository _repository;

  GetBookingHistoryUseCase(this._repository);

  Future<Either<Failure, List<BookingEntity>>> call() {
    return _repository.getBookingHistory();
  }
}