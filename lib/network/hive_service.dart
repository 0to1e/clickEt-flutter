import 'package:ClickEt/app/constants/hive_table_constant.dart';
import 'package:ClickEt/features/movie/data/model/movie_hive_model.dart';
import 'package:ClickEt/features/movie/domain/entity/movie_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ClickEt/features/auth/data/model/auth_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}clickEt.db';

    Hive.init(path);

    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(MovieHiveModelAdapter());
  }

  // Auth Queries
  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  // Login using username and password
  Future<AuthHiveModel?> login(String userName, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere((element) =>
        element.userName == userName && element.password == password);
    box.close();
    return user;
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  // Clear user Box
  Future<void> clearuserBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  Future<void> close() async {
    await Hive.close();
  }

//Movie Box
  Future<void> cacheMovies(List<MovieEntity> movies) async {
    final box = await Hive.openBox<MovieHiveModel>(HiveTableConstant.movieBox);
    await box.clear();
    // Convert MovieEntity to MovieHiveModel
    final hiveMovies = movies.map(MovieHiveModel.fromEntity).toList();
    await box.addAll(hiveMovies);
  }

  /// Returns all "showing" movies as MovieEntity
  Future<List<MovieEntity>> getCachedShowingMovies() async {
    final box = await Hive.openBox<MovieHiveModel>(HiveTableConstant.movieBox);
    return box.values
        .where((item) => item.status == 'showing')
        .map((item) => item.toEntity())
        .toList();
  }

  /// Returns all "upcoming" movies as MovieEntity
  Future<List<MovieEntity>> getCachedUpcomingMovies() async {
    final box = await Hive.openBox<MovieHiveModel>(HiveTableConstant.movieBox);
    final results = box.values
        .where((movieHive) => movieHive.status == 'upcoming')
        .map((movieHive) => movieHive.toEntity())
        .toList();
    return results;
  }
}
