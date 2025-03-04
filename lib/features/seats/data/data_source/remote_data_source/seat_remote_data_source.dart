import 'package:ClickEt/app/constants/api_endpoints.dart';
import 'package:ClickEt/features/seats/data/data_source/seat_data_source.dart';
import 'package:ClickEt/features/seats/data/model/seat_api_model.dart';
import 'package:ClickEt/features/seats/domain/entity/seat_entity.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:ClickEt/core/error/failure.dart';

class SeatRemoteDataSource implements ISeatDataSource {
  final Dio dio;

  SeatRemoteDataSource(this.dio);

  @override
  Future<Either<Failure, SeatLayoutEntity>> getSeatLayout(
      String screeningId) async {
    try {
      final response =
          await dio.get('${ApiEndpoints.layoutByScreening}/$screeningId');
      if (response.statusCode == 200) {
        final apiModel = SeatLayoutApiModel.fromJson(response.data);
        return Right(apiModel.toEntity());
      } else {
        return Left(ApiFailure(
            message: 'Failed to fetch seat layout',
            statusCode: response.statusCode));
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HoldResponseEntity>> holdSeats(
      String screeningId, List<SeatPosition> seats) async {
    try {
      final data = {
        'screeningId': screeningId,
        'seats': seats
            .map((s) => {
                  'section': s.section,
                  'row': s.row,
                  'seatNumber': s.seatNumber,
                })
            .toList(),
      };
      final response = await dio.post(ApiEndpoints.holdSeats, data: data);
      if (response.statusCode == 200) {
        return Right(HoldResponseEntity(
          message: response.data['message'],
          holdId: response.data['holdId'],
          bookingId: response.data['bookingId'],
          expiresAt: DateTime.parse(response.data['expiresAt']),
        ));
      } else {
        return Left(ApiFailure(
            message: 'Failed to hold seats', statusCode: response.statusCode));
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> releaseHold(String holdId) async {
    try {
      final response = await dio.delete('${ApiEndpoints.releaseHold}/$holdId');
      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(ApiFailure(
            message: 'Failed to release hold',
            statusCode: response.statusCode));
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BookingResponseEntity>> confirmBooking(
      String holdId) async {
    try {
      final data = {'holdId': holdId};
      final response = await dio.post(ApiEndpoints.confirmBooking, data: data);
      if (response.statusCode == 200) {
        return Right(BookingResponseEntity(
          message: response.data['message'],
          confirmationCode: response.data['confirmationCode'],
          bookingDetails: response.data['bookingDetails'],
        ));
      } else {
        return Left(ApiFailure(
            message: 'Failed to confirm booking',
            statusCode: response.statusCode));
      }
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
