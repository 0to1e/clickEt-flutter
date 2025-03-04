import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/features/auth/domain/use_case/login_use_case.dart';
import 'package:ClickEt/features/auth/domain/use_case/repository.mock.dart';
import 'package:ClickEt/features/auth/domain/use_case/token.mock.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockAuthRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late LoginUseCase loginUseCase;

  setUp(() {
    repository = MockAuthRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    loginUseCase = LoginUseCase(repository);
  });
  const userLoginParams = LoginParams(
    username: "r01en",
    password: "Prajwal123",
  );

  const generatedToken = "mock_jwt_token";
  group('LoginUseCase Tests', () {
    test('should return Failure when credentials are incorrect', () async {
      // Arrange
      when(() => repository.loginUser(any(), any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Invalid user credentials")));

      // Act
      final result = await loginUseCase(userLoginParams);

      // Assert
      expect(
          result, const Left(ApiFailure(message: "Invalid user credentials")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });

    test('should return Failure when username is empty', () async {
      // Arrange
      const userLoginParams = LoginParams(username: "", password: "Prajwal123");
      when(() => repository.loginUser(any(), any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Username cannot be empty")));

      // Act
      final result = await loginUseCase(userLoginParams);

      // Assert
      expect(
          result, const Left(ApiFailure(message: "Username cannot be empty")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });

    test('should return Failure when password is empty', () async {
      // Arrange
      const userLoginParams = LoginParams(username: "r01en", password: "");
      when(() => repository.loginUser(any(), any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Password cannot be empty")));

      // Act
      final result = await loginUseCase(userLoginParams);

      // Assert
      expect(
          result, const Left(ApiFailure(message: "Password cannot be empty")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });

    test('should return Failure when there is a server error', () async {
      // Arrange
      when(() => repository.loginUser(any(), any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Internal Server Error")));

      // Act
      final result = await loginUseCase(userLoginParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Internal Server Error")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => tokenSharedPrefs.saveToken(any()));
    });

    test('should login successfully and return token', () async {
      // Arrange
      when(() => repository.loginUser(any(), any()))
          .thenAnswer((_) async => const Right(generatedToken));
      when(() => tokenSharedPrefs.saveToken(any()))
          .thenAnswer((_) async => const Right(null));
      when(() => tokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right(generatedToken));

      // Act
      final result = await loginUseCase(userLoginParams);

      // Assert
      expect(result, const Right(generatedToken));
      verify(() => repository.loginUser(
          userLoginParams.username, userLoginParams.password)).called(1);
      verify(() => tokenSharedPrefs.saveToken(generatedToken)).called(1);
      verify(() => tokenSharedPrefs.getToken()).called(1);
    });
  });
}
