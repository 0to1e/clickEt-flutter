import 'package:ClickEt/app/constants/api_constants.dart';
import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/features/movie/data/model/movie_api_model.dart';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class RemoteMovieDataSource {
  final Dio _dio;

  RemoteMovieDataSource(this._dio);

  Future<Either<Failure, List<MovieEntity>>> getShowingMovies() async {
    try {
      final response = await _dio.get(ApiEndpoints.getShowingMovies);
      if (response.statusCode == 200) {
        final List<dynamic> moviesJson = response.data['movies'];
        final movies = moviesJson.map((json) => MovieApiModel.fromJson(json).toEntity()).toList();
        return Right(movies);
      } else {
        throw Exception("Failed to fetch showing movies from API");
      }
    } catch (e) {
      return Left(ApiFailure(message: "API Error: $e"));
    }
  }

  Future<Either<Failure, List<MovieEntity>>> getUpcomingMovies() async {
    try {
      final response = await _dio.get(ApiEndpoints.getUpcomingMovies);
      if (response.statusCode == 200) {
        final List<dynamic> moviesJson = response.data['movies'];
        final movies = moviesJson.map((json) => MovieApiModel.fromJson(json).toEntity()).toList();
        return Right(movies);
      } else {
        throw Exception("Failed to fetch upcoming movies from API");
      }
    } catch (e) {
      return Left(ApiFailure(message: "API Error: $e"));
    }
  }
}