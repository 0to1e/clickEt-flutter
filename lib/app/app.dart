import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ClickEt/core/theme/theme_cubit.dart';
import 'package:ClickEt/core/theme/get_app_theme.dart';
import 'package:ClickEt/features/splash/presentation/view/splash_view.dart';
import 'package:ClickEt/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:ClickEt/app/di/di.dart';
import 'package:ClickEt/core/navigation/global_navigator.dart'; // Import your global navigator

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(initialTheme: false),
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
          return MaterialApp(
            navigatorKey: globalNavigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'ClickEt',
            theme: AppTheme.getApplicationTheme(isDarkMode: false),
            darkTheme: AppTheme.getApplicationTheme(isDarkMode: true),
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: BlocProvider.value(
              value: getIt<SplashCubit>(),
              child: const SplashView(),
            ),
          );
        },
      ),
    );
  }
}
