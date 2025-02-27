import 'package:ClickEt/app/di/di.dart';
import 'package:ClickEt/features/auth/data/repository/auth_local_repository.dart';
import 'package:ClickEt/features/home/presentation/view/home_view.dart';
import 'package:ClickEt/features/movie/presentation/view_model/movie_bloc.dart';
import 'package:ClickEt/features/onboarding/presentation/view/on_boarding_view.dart';
import 'package:ClickEt/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SplashCubit extends Cubit<void> {
  SplashCubit(this._onBoardingCubit) : super(null);

  final OnboardingCubit _onBoardingCubit;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      final userResult = await getIt<AuthLocalRepository>().getCurrentUser();

      print(userResult);
      if (userResult.isRight()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<MovieBloc>(),
              child: const HomeView(),
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _onBoardingCubit,
              child: const OnboardingView(),
            ),
          ),
        );
      }
    });
  }
}
