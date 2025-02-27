// import 'package:ClickEt/app/app.dart';
import 'package:ClickEt/app/app.dart';
import 'package:ClickEt/app/di/di.dart';
import 'package:ClickEt/core/sensor/shake_cubit.dart';
import 'package:ClickEt/core/theme/theme_cubit.dart';
import 'package:ClickEt/features/movie/presentation/view_model/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  final prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: ThemeCubit(initialTheme: isDarkMode),
        ),
        BlocProvider(create: (_) => getIt<MovieBloc>()),
        BlocProvider(create: (_) => getIt<ShakeCubit>()),
      ],
      child: const App(),
    ),
  );
}
