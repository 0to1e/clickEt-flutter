import 'package:ClickEt/features/splash/presentation/view/splash_view.dart';
import 'package:ClickEt/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ClickEt/app/di/di.dart';
import 'package:ClickEt/core/theme/get_app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User Management',
        theme: AppTheme.getApplicationTheme(isDarkMode: false),
        home: BlocProvider.value(
          value: getIt<SplashCubit>(),
          child: const SplashView(),
        ));
  }
}
