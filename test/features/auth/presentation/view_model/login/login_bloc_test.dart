import 'package:bloc_test/bloc_test.dart';
import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/core/sensor/shake_cubit.dart';
import 'package:ClickEt/features/auth/domain/use_case/login_use_case.dart';
import 'package:ClickEt/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:ClickEt/features/movie/presentation/view_model/movie_bloc.dart';
import 'package:ClickEt/network/hive_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockMovieBloc extends Mock implements MovieBloc {}

class MockHiveService extends Mock implements HiveService {}

class MockShakeCubit extends Mock implements ShakeCubit {}

// Fake LoginParams
class FakeLoginParams extends Fake implements LoginParams {
  @override
  String get username => '';

  @override
  String get password => '';
}

void main() {
  group('LoginBloc', () {
    late LoginUseCase loginUseCase;
    late MovieBloc movieBloc;
    late HiveService hiveService;
    late ShakeCubit shakeCubit;
    late LoginBloc loginBloc;

    setUpAll(() {
      registerFallbackValue(FakeLoginParams());
    });

    setUp(() {
      loginUseCase = MockLoginUseCase();
      movieBloc = MockMovieBloc();
      hiveService = MockHiveService();
      shakeCubit = MockShakeCubit();

      loginBloc = LoginBloc(
        loginUseCase: loginUseCase,
        movieBloc: movieBloc,
        hiveService: hiveService,
        shakeCubit: shakeCubit,
      );
    });

    tearDown(() {
      loginBloc.close();
    });

    blocTest<LoginBloc, LoginState>(
      'emits state with toggled password visibility when TogglePasswordVisibilityEvent is added',
      build: () => loginBloc,
      act: (bloc) => bloc.add(const TogglePasswordVisibilityEvent()),
      expect: () => [
        LoginState.initial().copyWith(isPasswordVisible: true),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits error state when login form is invalid (empty fields)',
      build: () => loginBloc,
      act: (bloc) {
        final context = MaterialApp(home: Container()).createElement();
        bloc.add(LoginSubmittedEvent(
          context: context,
          username: "",
          password: "",
        ));
      },
      expect: () => [
        LoginState.initial().copyWith(
          errorMessage: "Username/Email and password are required",
        ),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits loading and success states on successful login',
      build: () {
        when(() => loginUseCase(any())).thenAnswer(
          (_) async => const Right("Success"),
        );
        when(() => shakeCubit.startListening()).thenReturn(null);
        return loginBloc;
      },
      act: (bloc) {
        final context = MaterialApp(home: Container()).createElement();
        bloc.add(LoginSubmittedEvent(
          context: context,
          username: "testuser",
          password: "password123",
        ));
      },
      expect: () => [
        LoginState.initial().copyWith(isLoading: true),
        LoginState.initial().copyWith(
          isLoading: false,
          isSuccess: true,
          isLoggedIn: true,
          navigateToMain: true,
        ),
      ],
      verify: (_) {
        verify(() => loginUseCase(any())).called(1);
        verify(() => shakeCubit.startListening()).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits loading and failure states on login failure',
      build: () {
        when(() => loginUseCase(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: "Failure")),
        );
        return loginBloc;
      },
      act: (bloc) {
        final context = MaterialApp(home: Container()).createElement();
        bloc.add(LoginSubmittedEvent(
          context: context,
          username: "testuser",
          password: "wrongpassword",
        ));
      },
      expect: () => [
        LoginState.initial().copyWith(isLoading: true),
        LoginState.initial().copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: "Invalid Credentials",
        ),
      ],
      verify: (_) {
        verify(() => loginUseCase(any())).called(1);
      },
    );
  });
}