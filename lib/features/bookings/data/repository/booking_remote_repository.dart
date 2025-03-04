// lib/features/booking/data/repository/booking_repository.dart
import 'package:ClickEt/features/bookings/data/data_source/remote_data_source/booking_remote_data_source.dart';
import 'package:ClickEt/features/bookings/domain/entity/booking_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:ClickEt/core/error/failure.dart';


class BookingRepository {
  final BookingRemoteDataSource _remoteDataSource;

  BookingRepository(this._remoteDataSource);

  Future<Either<Failure, List<BookingEntity>>> getBookingHistory() async {
    final result = await _remoteDataSource.getBookingHistory();
    return result.fold(
      (failure) => Left(failure),
      (bookings) => Right(bookings.map((model) => model.toEntity()).toList()),
    );
  }


}
