import 'package:ClickEt/features/movie/data/data_source/movie_data_source.dart';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:ClickEt/network/hive_service.dart';

class LocalMovieDataSource implements IMovieDataSource {
  final HiveService _hiveService;

  LocalMovieDataSource(this._hiveService);

  @override
  Future<void> cacheMovies(List<MovieEntity> movies) async {
    await _hiveService.cacheMovies(movies);
  }

  @override
  Future<List<MovieEntity>> getShowingMovies() async {
    return _hiveService.getCachedShowingMovies();
  }

  @override
  Future<List<MovieEntity>> getUpcomingMovies() async {
    return _hiveService.getCachedUpcomingMovies();
  }

  @override
  Future<List<MovieEntity>> getCachedShowingMovies() {
    return _hiveService.getCachedShowingMovies();
  }

  @override
  Future<List<MovieEntity>> getCachedUpcomingMovies() {
    return _hiveService.getCachedUpcomingMovies();
  }
}
