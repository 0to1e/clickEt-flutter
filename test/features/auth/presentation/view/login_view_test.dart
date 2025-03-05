import 'package:ClickEt/features/auth/presentation/view/login_view.dart';
import 'package:ClickEt/features/auth/presentation/view_model/login/login_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Create a fake LoginEvent for mocktail.
class FakeLoginEvent extends Mock implements LoginEvent {}

class MockLoginBloc extends Mock implements LoginBloc {}

void main() {
  // Register fallback value for LoginEvent.
  setUpAll(() {
    registerFallbackValue(FakeLoginEvent());
  });

  group('LoginView Widget Test', () {
    late LoginBloc loginBloc;

    setUp(() {
      loginBloc = MockLoginBloc();
      when(() => loginBloc.state).thenReturn(LoginState.initial());
      when(() => loginBloc.stream).thenAnswer(
          (_) => Stream<LoginState>.fromIterable([LoginState.initial()]));
    });

    testWidgets(
        'renders login view and triggers LoginSubmittedEvent on button press',
        (WidgetTester tester) async {
      // Wrap with MediaQuery to provide a larger width (avoid RenderFlex overflow)
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(500, 800)),
          child: MaterialApp(
            home: BlocProvider<LoginBloc>.value(
              value: loginBloc,
              child: const LoginViewContent(),
            ),
          ),
        ),
      );

      // Verify that the welcome text appears.
      expect(find.text("Welcome Back!"), findsOneWidget);

      // Find the username and password TextFields by their label.
      final usernameField = find.byWidgetPredicate(
        (widget) =>
            widget is TextField &&
            widget.decoration?.labelText == 'username/E-mail',
      );
      final passwordField = find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration?.labelText == 'Password',
      );

      expect(usernameField, findsOneWidget);
      expect(passwordField, findsOneWidget);

      // Enter text into the username and password fields.
      await tester.enterText(usernameField, "testuser");
      await tester.enterText(passwordField, "password123");

      // Tap the "Sign in" button.
      final signInButton = find.text("Sign in");
      expect(signInButton, findsOneWidget);
      await tester.tap(signInButton);
      await tester.pumpAndSettle();

      // Verify that LoginSubmittedEvent is added to the bloc.
      verify(() => loginBloc.add(any(that: isA<LoginSubmittedEvent>())))
          .called(1);
    });
  });
}
