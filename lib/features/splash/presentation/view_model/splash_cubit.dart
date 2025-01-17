import 'package:ClickEt/features/onboarding/presentation/view/on_boarding_view.dart';
import 'package:ClickEt/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SplashCubit extends Cubit<void> {
  SplashCubit(this._onBoardingCubit) : super(null);

  final OnboardingCubit _onBoardingCubit;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      // Open Login page or Onboarding Screen

      if (context.mounted) {
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
