import 'package:ClickEt/app/di/di.dart';
import 'package:ClickEt/features/auth/presentation/view/registration_view.dart';
import 'package:ClickEt/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockRegisterBloc extends Mock implements RegisterBloc {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  late MockRegisterBloc mockRegisterBloc;
  late FakeBuildContext fakeContext;

  setUpAll(() {
    // Create a fake context instance
    fakeContext = FakeBuildContext();

    // Register fallback values
    registerFallbackValue(fakeContext);
    registerFallbackValue(RegisterUser(
      context: fakeContext, // Use fake context instead of null
      fullName: '',
      username: '',
      email: '',
      phone: '',
      password: '',
    ));
  });

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();
    getIt.registerFactory<RegisterBloc>(() => mockRegisterBloc);
    when(() => mockRegisterBloc.stream)
        .thenAnswer((_) => Stream.value(RegisterState.initial()));
    when(() => mockRegisterBloc.state).thenReturn(RegisterState.initial());
    when(() => mockRegisterBloc.close()).thenAnswer((_) async {});
  });

  tearDown(() {
    getIt.reset();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<RegisterBloc>.value(
        value: mockRegisterBloc,
        child: const RegistrationView(),
      ),
    );
  }

  group('RegistrationView', () {
    testWidgets('renders all UI elements correctly', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Create an Account'), findsOneWidget);
      expect(
          find.text('Please fill in the details to sign up'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(5));
      expect(find.text('Full name'), findsOneWidget);
      expect(find.text('User name'), findsOneWidget);
      expect(find.text('Email-address'), findsOneWidget);
      expect(find.text('Phone number'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text('Already have an account? '), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('triggers RegisterUser event when Sign Up button is tapped',
        (tester) async {
      when(() => mockRegisterBloc.add(any())).thenAnswer((_) async {});

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(0), 'John Doe');
      await tester.enterText(find.byType(TextField).at(1), 'johndoe');
      await tester.enterText(find.byType(TextField).at(2), 'john@example.com');
      await tester.enterText(find.byType(TextField).at(3), '1234567890');
      await tester.enterText(find.byType(TextField).at(4), 'password123');
      await tester.tap(find.text('Sign Up'));
      await tester.pump();

      verify(() => mockRegisterBloc.add(any(that: isA<RegisterUser>())))
          .called(1);
    });

    testWidgets('shows loading state when bloc is loading', (tester) async {
      when(() => mockRegisterBloc.state).thenReturn(
        const RegisterState(isLoading: true, isSuccess: false),
      );
      when(() => mockRegisterBloc.stream).thenAnswer((_) => Stream.value(
            const RegisterState(isLoading: true, isSuccess: false),
          ));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Create an Account'), findsOneWidget);
      // Add more assertions here if you add a loading indicator to your UI
    });
  });
}