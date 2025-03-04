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
      print("Fetching showing movies from API");
      final response = await _dio.get(ApiEndpoints.getShowingMovies);
      if (response.statusCode == 200) {
        final List<dynamic> moviesJson = response.data['movies'];
        final movies = moviesJson.map((json) => MovieApiModel.fromJson(json).toEntity()).toList();
        print("Successfully fetched ${movies.length} showing movies");
        return Right(movies);
      } else {
        print("Failed to fetch showing movies from API. Status code: ${response.statusCode}");
        throw Exception("Failed to fetch showing movies from API");
      }
    } catch (e) {
      print("API Error while fetching showing movies: $e");
      return Left(ApiFailure(message: "API Error: $e"));
    }
  }

  Future<Either<Failure, List<MovieEntity>>> getUpcomingMovies() async {
    try {
      print("Fetching upcoming movies from API");
      final response = await _dio.get(ApiEndpoints.getUpcomingMovies);
      if (response.statusCode == 200) {
        final List<dynamic> moviesJson = response.data['movies'];
        final movies = moviesJson.map((json) => MovieApiModel.fromJson(json).toEntity()).toList();
        print("Successfully fetched ${movies.length} upcoming movies");
        return Right(movies);
      } else {
        print("Failed to fetch upcoming movies from API. Status code: ${response.statusCode}");
        throw Exception("Failed to fetch upcoming movies from API");
      }
    } catch (e) {
      print("API Error while fetching upcoming movies: $e");
      return Left(ApiFailure(message: "API Error: $e"));
    }
  }
}