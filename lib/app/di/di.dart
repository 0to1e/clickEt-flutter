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
    // Initialize Hive service
    await _initHiveService();

    // Initialize data sources and repositories
    _initAuthDataSourcesAndRepositories();

    // Initialize use cases
    _initUseCases();

    // Initialize BLoCs and Cubits
    _initBlocsAndCubits();
  } catch (e) {
    logger.e("Error initializing dependencies: $e");
  }
}

Future<void> _initHiveService() async {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

void _initAuthDataSourcesAndRepositories() {
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthLocalRepository>(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );
}

void _initUseCases() {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthLocalRepository>()),
  );

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthLocalRepository>()),
  );
}

// void _initBlocsAndCubits() {
//   // Register SplashCubit
//   getIt.registerFactory<SplashCubit>(
//     () => SplashCubit(getIt<OnboardingCubit>()),
//   );

//   // Register OnboardingCubit
//   getIt.registerFactory<OnboardingCubit>(
//     () => OnboardingCubit(),
//   );

//   // Register LoginBloc
//   getIt.registerFactory<LoginBloc>(
//     () => LoginBloc(loginUseCase: getIt<LoginUseCase>()),
//   );

//   // Register RegisterBloc
//   getIt.registerFactory<RegisterBloc>(
//     () => RegisterBloc(registerUseCase: getIt<RegisterUseCase>()),
//   );

//   // Register GetStartedCubit
//   getIt.registerFactory<GetStartedCubit>(
//     () => GetStartedCubit(
//       getIt<LoginBloc>(),
//       getIt<RegisterBloc>(),
//     ),
//   );

//   // Register HomeBloc
//   getIt.registerFactory<HomeBloc>(
//     () => HomeBloc(),
//   );
// }

void _initBlocsAndCubits() {
  // Register SplashCubit
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<OnboardingCubit>()),
  );

  // Register OnboardingCubit
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(),
  );

  // Register GetStartedCubit with its dependencies
  getIt.registerFactory<GetStartedCubit>(
    () => GetStartedCubit(),
  );

  // Register LoginBloc as a factory instead of singleton
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(loginUseCase: getIt<LoginUseCase>()),
  );

  // Register RegisterBloc as a factory instead of singleton
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUseCase>(),
    ),
  );
  // Register HomeBloc
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(),
  );
}