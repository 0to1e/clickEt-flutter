import 'package:ClickEt/features/get_started/presentation/view/get_started_view.dart';
import 'package:ClickEt/features/onboarding/presentation/view/on_board_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  final PageController pageController = PageController();

  OnboardingCubit() : super(0);

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

  void skipToLastPage() async {
    final lastPageIndex = pages.length - 1;
    emit(lastPageIndex); // Update the state to the last page

    // Wait for a short delay to ensure the PageController is attached
    await Future.delayed(const Duration(milliseconds: 100));

    if (pageController.hasClients) {
      pageController.jumpToPage(lastPageIndex); // Jump to the last page
    } else {
      print("PageController still has no clients after delay"); // Debugging
    }
  }

  void navigateToAuthScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const GetStartedView(),
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
