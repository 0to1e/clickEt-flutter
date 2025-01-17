import 'package:ClickEt/common/button.dart';
import 'package:ClickEt/features/onboarding/presentation/view/on_board_model.dart';
import 'package:ClickEt/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<OnboardingCubit, int>(
                  builder: (context, currentPage) {
                    final cubit = context.read<OnboardingCubit>();
                    return PageView(
  controller: cubit.pageController, // Ensure this is correct
  onPageChanged: cubit.onPageChanged,
  children: pages.map((page) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(page.imagePath, height: 300),
        const SizedBox(height: 20),
        Text(
          page.title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 10),
        Text(
          page.description,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }).toList(),
);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button(
                      text: 'Skip',
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      onPressed: () {
                        context.read<OnboardingCubit>().skipToLastPage();
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<OnboardingCubit, int>(
                      builder: (context, currentPage) {
                        final cubit = context.read<OnboardingCubit>();
                        return Button(
                          text: currentPage == pages.length - 1
                              ? 'Get Started'
                              : 'Next',
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          onPressed: () {
                            if (currentPage < pages.length - 1) {
                              cubit.goToNextPage();
                            } else {
                              cubit.navigateToAuthScreen(context);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<OnboardingCubit, int>(
                builder: (context, currentPage) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(pages.length, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: currentPage == index ? 20 : 8,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
