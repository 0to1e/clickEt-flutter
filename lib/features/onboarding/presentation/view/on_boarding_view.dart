import 'package:ClickEt/common/widgets/button.dart';
import 'package:ClickEt/features/onboarding/presentation/view/on_board_model.dart';
import 'package:ClickEt/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          
            Expanded(
              child: BlocBuilder<OnboardingCubit, int>(
                builder: (context, currentPage) {
                  final cubit = context.read<OnboardingCubit>();
                  return PageView(
                    controller: cubit.pageController,
                    onPageChanged: cubit.onPageChanged,
                    children: pages.map((page) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(page.imagePath,
                              height: 200), 
                          const SizedBox(height: 16),
                          Text(
                            page.title,
                            style: Theme.of(context).textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              page.description,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            // Bottom section with buttons and dots
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<OnboardingCubit, int>(
                    builder: (context, currentPage) {
                      final cubit = context.read<OnboardingCubit>();
                      return Button(
                        text: "Skip",
                        height: 40, 
                        onPressed: cubit.skipToLastPage,
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<OnboardingCubit, int>(
                    builder: (context, currentPage) {
                      final cubit = context.read<OnboardingCubit>();
                      return Button(
                        text: currentPage == pages.length - 1
                            ? 'Get Started'
                            : 'Next',
                        height: 40,
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
                  const SizedBox(height: 10), 
                  BlocBuilder<OnboardingCubit, int>(
                    builder: (context, currentPage) {
                      return Row(
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
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
