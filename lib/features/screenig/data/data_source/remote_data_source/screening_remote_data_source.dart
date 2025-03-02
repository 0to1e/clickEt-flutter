import 'package:ClickEt/features/screenig/data/data_source/screening_data_source.dart';
import 'package:ClickEt/features/screenig/domain/entity/screening_entity.dart';
import 'package:dio/dio.dart';
import 'package:ClickEt/app/constants/api_constants.dart';
import 'package:ClickEt/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class ScreeningRemoteDataSource implements IScreeningDataSource {
  final Dio _dio;

  ScreeningRemoteDataSource(this._dio);

  @override
  // Future<Either<Failure, List<ScreeningEntity>>> getScreeningsByMovie(
  //     String movieId) async {
  //   try {
  //     final response =
  //         await _dio.get('${ApiEndpoints.getScreeningbyMovie}/$movieId');
  //     if (response.statusCode == 200) {
  //       final List<dynamic> screeningsJson = response.data;
  //       final screenings = screeningsJson
  //           .map((json) => ScreeningApiModel.fromJson(json).toEntity())
  //           .toList();
  //       return Right(screenings);
  //     } else {
  //       return Left(ApiFailure(
  //           message: "Failed to fetch screenings",
  //           statusCode: response.statusCode));
  //     }
  //   } on DioException catch (e) {
  //     return Left(ApiFailure(message: "API Error: ${e.message}"));
  //   } catch (e) {
  //     return Left(ApiFailure(message: "Unexpected error: $e"));
  //   }
  // }
  Future<Either<Failure, List<ScreeningEntity>>> getScreeningsByMovie(
      String movieId) async {
    try {
      final response =
          await _dio.get('${ApiEndpoints.getScreeningbyMovie}/$movieId');

      final screenings = (response.data as List)
          .map((json) => ScreeningEntity.fromJson(json))
          .toList();
      return Right(screenings);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return const Left(
            ApiFailure(message: 'No screenings found for this movie'));
      }
      return Left(ApiFailure(
        message: e.response?.data['message'] ?? 'Failed to fetch screenings',
        statusCode: e.response?.statusCode,
      ));
    }
  }
}
