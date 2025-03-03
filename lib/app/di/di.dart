import 'dart:async';
import 'package:ClickEt/core/network/api_service.dart';
import 'package:ClickEt/core/sensor/shake_cubit.dart';
import 'package:ClickEt/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:ClickEt/features/auth/data/repository/auth_remote_repository.dart';
import 'package:ClickEt/features/movie/data/data_source/local_data_source/movie_local_data_source.dart';
import 'package:ClickEt/features/movie/data/data_source/remote_data_source/movie_remote_data_source.dart';
import 'package:ClickEt/features/movie/data/repository/hybrid_movie_repository.dart';
import 'package:ClickEt/features/movie/data/repository/movie_local_repository.dart';
import 'package:ClickEt/features/movie/data/repository/movie_remote_repository.dart';
import 'package:ClickEt/features/movie/domain/use_case/cache_movies_use_case.dart';
import 'package:ClickEt/features/movie/domain/use_case/get_showing_use_case.dart';
import 'package:ClickEt/features/movie/domain/use_case/get_upcoming_use_case.dart';
import 'package:ClickEt/features/movie/presentation/view_model/movie_bloc.dart';
import 'package:ClickEt/features/screenig/data/data_source/remote_data_source/screening_remote_data_source.dart';
import 'package:ClickEt/features/screenig/data/repository/screening_remote_repository.dart';
import 'package:ClickEt/features/screenig/domain/repository/screening_repository.dart';
import 'package:ClickEt/features/screenig/domain/usecase/get_screening_by_movie_usecase.dart';
import 'package:ClickEt/features/screenig/presentation/view_model/screening_bloc.dart';
import 'package:ClickEt/features/seats/data/data_source/remote_data_source/seat_remote_data_source.dart';
import 'package:ClickEt/features/seats/data/data_source/seat_data_source.dart';
import 'package:ClickEt/features/seats/data/repository/seat_remote_repository.dart';
import 'package:ClickEt/features/seats/domain/repository/seat_repository.dart';
import 'package:ClickEt/features/seats/domain/use_case/confirm_booking_use_case.dart';
import 'package:ClickEt/features/seats/domain/use_case/get_seat_layout_use_case.dart';
import 'package:ClickEt/features/seats/domain/use_case/hold_seats_use_case.dart';
import 'package:ClickEt/features/seats/domain/use_case/release_hold_use_case.dart';
import 'package:ClickEt/features/seats/presentation/view_model/seat_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ClickEt/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:ClickEt/features/auth/data/repository/auth_local_repository.dart';
import 'package:ClickEt/features/auth/domain/use_case/login_use_case.dart';
import 'package:ClickEt/features/auth/domain/use_case/register_use_case.dart';
import 'package:ClickEt/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:ClickEt/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:ClickEt/features/get_started/presentation/view_model/get_started_cubit.dart';
import 'package:ClickEt/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:ClickEt/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:ClickEt/features/home/presentation/view_model/home_bloc.dart';
import 'package:ClickEt/network/hive_service.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;
final logger = Logger();

Future<void> initDependencies() async {
  try {
    await _initAccelerometerDependency();
    await _initHiveService();
    await _initApiService();
    await _initConnectivityService();
    await _initSplashDependencies();
    await _initOnboardingDependencies();
    await _initGetStartedDependencies();
    await _iniitAuthDependencies();
    await _initHomeDependencies();
    await _initMovieDependencies();
    await _initScreeningDependencies();
    await _initSeatDependencies();
  } catch (e) {
    logger.e("Error initializing dependencies: $e");
  }
}

Future<void> _initHiveService() async {
  await HiveService.init();
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

Future<void> _initAccelerometerDependency() async {
  getIt.registerLazySingleton<ShakeCubit>(
      () => ShakeCubit(movieBloc: getIt<MovieBloc>()));
}

Future<void> _initConnectivityService() async {
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
}

Future<void> _initApiService() async {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

Future<void> _iniitAuthDependencies() async {
  // ====================================================** Data Sources
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // ====================================================** Data Repository

  getIt.registerLazySingleton<AuthLocalRepository>(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // ====================================================** Use Cases

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRemoteRepository>()),
  );
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  // ====================================================** Bloc/Cubits

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
        loginUseCase: getIt<LoginUseCase>(),
        movieBloc: getIt<MovieBloc>(),
        hiveService: getIt<HiveService>(),
        shakeCubit: getIt<ShakeCubit>()),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUseCase>(),
    ),
  );
}

Future<void> _initSplashDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<OnboardingCubit>()),
  );
}

Future<void> _initOnboardingDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(getIt<GetStartedCubit>()),
  );
}

Future<void> _initGetStartedDependencies() async {
  getIt.registerFactory<GetStartedCubit>(
    () => GetStartedCubit(
        getIt<LoginBloc>(), getIt<RegisterBloc>(), getIt<HomeBloc>()),
  );
}

Future<void> _initHomeDependencies() async {
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(),
  );
}

Future<void> _initMovieDependencies() async {
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepository(getIt<RemoteMovieRepository>(),
        getIt<LocalMovieRepository>(), getIt<Connectivity>()),
  );
  getIt.registerLazySingleton<RemoteMovieRepository>(
    () => RemoteMovieRepository(getIt<RemoteMovieDataSource>()),
  );
  getIt.registerLazySingleton<LocalMovieRepository>(
    () => LocalMovieRepository(getIt<LocalMovieDataSource>()),
  );

  getIt.registerLazySingleton<RemoteMovieDataSource>(
      () => RemoteMovieDataSource(getIt<Dio>()));

  getIt.registerLazySingleton<LocalMovieDataSource>(
      () => LocalMovieDataSource(getIt<HiveService>()));
  getIt.registerLazySingleton<CacheMoviesUseCase>(
    () => CacheMoviesUseCase(getIt<LocalMovieDataSource>()),
  );
  getIt.registerLazySingleton<MovieBloc>(
    () => MovieBloc(
        getUpcomingMoviesUseCase: getIt<GetUpcomingMoviesUseCase>(),
        getShowingMoviesUseCase: getIt<GetShowingMoviesUseCase>(),
        cacheMoviesUseCase: getIt<CacheMoviesUseCase>(),
        connectivity: getIt<Connectivity>()),
  );
  getIt.registerLazySingleton<GetShowingMoviesUseCase>(
      () => GetShowingMoviesUseCase(getIt<MovieRepository>()));
  getIt.registerLazySingleton<GetUpcomingMoviesUseCase>(
      () => GetUpcomingMoviesUseCase(getIt<MovieRepository>()));
}

Future<void> _initScreeningDependencies() async {
  getIt.registerLazySingleton<ScreeningRemoteDataSource>(
    () => ScreeningRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<IScreeningRepository>(
    () => ScreeningRemoteRepository(getIt<ScreeningRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetScreeningsByMovieUseCase>(
    () => GetScreeningsByMovieUseCase(getIt<IScreeningRepository>()),
  );

  getIt.registerFactory<ScreeningBloc>(
    () => ScreeningBloc(
      getScreeningsByMovieUseCase: getIt<GetScreeningsByMovieUseCase>(),
    ),
  );
}

Future<void> _initSeatDependencies() async {
  // Register Data Source
  getIt.registerLazySingleton<ISeatDataSource>(
    () => SeatRemoteDataSource(getIt<Dio>()),
  );

  // Register Repository
  getIt.registerLazySingleton<ISeatRepository>(
    () => SeatRemoteRepository(getIt<ISeatDataSource>()),
  );

  // Register Use Cases
  getIt.registerLazySingleton<GetSeatLayoutUseCase>(
    () => GetSeatLayoutUseCase(getIt<ISeatRepository>()),
  );
  getIt.registerLazySingleton<HoldSeatsUseCase>(
    () => HoldSeatsUseCase(getIt<ISeatRepository>()),
  );
  getIt.registerLazySingleton<ReleaseHoldUseCase>(
    () => ReleaseHoldUseCase(getIt<ISeatRepository>()),
  );
  getIt.registerLazySingleton<ConfirmBookingUseCase>(
    () => ConfirmBookingUseCase(getIt<ISeatRepository>()),
  );

  // Register BLoC
  getIt.registerFactory<SeatBloc>(
    () => SeatBloc(
      getSeatLayoutUseCase: getIt<GetSeatLayoutUseCase>(),
      holdSeatsUseCase: getIt<HoldSeatsUseCase>(),
      releaseHoldUseCase: getIt<ReleaseHoldUseCase>(),
      confirmBookingUseCase: getIt<ConfirmBookingUseCase>(),
    ),
  );
}