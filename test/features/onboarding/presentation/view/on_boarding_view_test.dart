import 'package:ClickEt/features/get_started/presentation/view/get_started_view.dart';
import 'package:ClickEt/features/get_started/presentation/view_model/get_started_cubit.dart';
import 'package:ClickEt/features/onboarding/presentation/view/on_boarding_view.dart';
import 'package:ClickEt/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:ClickEt/features/onboarding/presentation/view/on_board_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetStartedCubit extends Mock implements GetStartedCubit {}

void main() {
  group('OnboardingView Widget Tests with Mocktail', () {
    late GetStartedCubit mockGetStartedCubit;
    late OnboardingCubit onboardingCubit;

    setUp(() {
      mockGetStartedCubit = MockGetStartedCubit();
      onboardingCubit = OnboardingCubit(mockGetStartedCubit);
    });

    tearDown(() async {
      await onboardingCubit.close();
    });

    testWidgets('displays initial onboarding page',
        (WidgetTester tester) async {

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<OnboardingCubit>.value(
            value: onboardingCubit,
            child: const OnboardingView(),
          ),
        ),
      );

      final firstPageTitle = pages.first.title;
      expect(find.text(firstPageTitle), findsOneWidget);
    });

    testWidgets('tapping Next goes to the next page',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<OnboardingCubit>.value(
            value: onboardingCubit,
            child: const OnboardingView(),
          ),
        ),
      );

      expect(find.text('Next'), findsOneWidget);
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      if (pages.length > 1) {
        final secondPageTitle = pages[1].title;
        expect(find.text(secondPageTitle), findsOneWidget);
      }
    });

    testWidgets(
        'tapping Skip jumps to the last page and shows Get Started button',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<OnboardingCubit>.value(
            value: onboardingCubit,
            child: const OnboardingView(),
          ),
        ),
      );

      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      final lastPageTitle = pages.last.title;
      expect(find.text(lastPageTitle), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);
    });

    testWidgets('tapping Get Started navigates to GetStartedView',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1080, 1920));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<OnboardingCubit>.value(
            value: onboardingCubit,
            child: const OnboardingView(),
          ),
        ),
      );

      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      // Check that the GetStartedView appears by finding its type.
      expect(find.byType(GetStartedView), findsOneWidget);
    });
  });
}
