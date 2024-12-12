import 'package:flutter/material.dart';

import 'package:ClickEt/common/button.dart';
import 'package:ClickEt/views/auth_screen.dart';
import 'package:ClickEt/model/onboard_model.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> pages = [
    OnboardingPage(
      imagePath: 'lib/assets/illustrations/onboarding/tickets.png',
      title: 'Effortless Ticket Booking',
      description: 'Discover the easiest way to buy movie tickets on-the-go.',
    ),
    OnboardingPage(
      imagePath: 'lib/assets/illustrations/onboarding/popcorn.png',
      title: 'Enjoy the Full Experience',
      description:
          'Explore movie showtimes, concessions, and more - all in one app.',
    ),
    OnboardingPage(
      imagePath: 'lib/assets/illustrations/onboarding/glasses.png',
      title: 'Plan Your Movie Night',
      description:
          'Browse showtimes, purchase tickets, and add events to your calendar - all in a few taps.',
    ),
  ];

  void _onNextPressed() {
    if (_currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthScreenView()),
      );
    }
  }

  void _onSkipPressed() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthScreenView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  final page = pages[index];
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
                    onPressed: _onSkipPressed,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                    text: _currentPage == pages.length - 1
                        ? 'Get Started'
                        : 'Next',
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    onPressed: _onNextPressed,
                  ),
                ],
              ),
            ),
            // Page Indicator
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pages.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: _currentPage == index ? 20 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Theme.of(context)
                              .colorScheme
                              .primary // Correctly using primaryColor
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
            // Skip and Next Buttons
          ],
        ),
      ),
    );
  }
}

