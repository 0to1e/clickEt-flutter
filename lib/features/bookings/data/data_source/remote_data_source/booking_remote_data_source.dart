// lib/features/booking/data/data_source/remote_data_source/booking_remote_data_source.dart
import 'package:ClickEt/features/bookings/data/model/booking_api_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ClickEt/app/constants/api_constants.dart';
import 'package:ClickEt/core/error/failure.dart';

class BookingRemoteDataSource {
  final Dio _dio;

  BookingRemoteDataSource(this._dio);

  Future<Either<Failure, List<BookingApiModel>>> getBookingHistory() async {
    try {
      final response = await _dio.get(ApiEndpoints.bookingHistory);
      if (response.statusCode == 200) {
        final List<dynamic> bookingsJson = response.data;
        final bookings =
            bookingsJson.map((json) => BookingApiModel.fromJson(json)).toList();
        return Right(bookings);
      } else {
        return const Left(
            ApiFailure(message: 'Failed to fetch booking history'));
      }
    } catch (e) {
      return Left(ApiFailure(message: 'Error fetching booking history: $e'));
    }
  }


}
