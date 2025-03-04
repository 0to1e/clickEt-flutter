import 'package:ClickEt/features/get_started/presentation/view/get_started_view.dart';
import 'package:ClickEt/features/get_started/presentation/view_model/get_started_cubit.dart';
import 'package:ClickEt/features/onboarding/presentation/view/on_board_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  final PageController pageController = PageController();
  final GetStartedCubit _getStartedCubit;

  OnboardingCubit(this._getStartedCubit) : super(0);

  void goToNextPage() {
    if (state < pages.length - 1) {
      emit(state + 1);
      if (pageController.hasClients) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void skipToLastPage() {
    final lastPageIndex = pages.length - 1;
    if (pageController.hasClients) {
      pageController.animateToPage(
        lastPageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    emit(lastPageIndex);
  }

  void navigateToAuthScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: _getStartedCubit,
          child: const GetStartedView(),
        ),
      ),
    );
  }

  void onPageChanged(int index) {
    emit(index);
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
