import 'package:ClickEt/features/auth/domain/entity/auth_entity.dart';
import 'package:ClickEt/features/auth/domain/use_case/register_use_case.dart';
import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/features/auth/domain/use_case/repository.mock.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockAuthRepository repository;
  late RegisterUseCase registerUseCase;

  setUp(() {
    repository = MockAuthRepository();
    registerUseCase = RegisterUseCase(repository);
    registerFallbackValue(const AuthEntity.empty());
  });

  const userParams = RegisterUserParams(
    fullName: "Rohan Chaulagain",
    userName: "r01en",
    phoneNumber: "9860452132",
    email: "roahhanchaulagain@gmail.com",
    password: "Prajwal123",
  );

  group('RegisterUseCase Tests', () {
    test('should return Failure when email is already taken', () async {
      // Arrange
      when(() => repository.registerUser(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: "Email already taken")));

      // Act
      final result = await registerUseCase(userParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Email already taken")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('should return Failure when phone number is invalid', () async {
      // Arrange
      when(() => repository.registerUser(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: "Invalid phone number")));

      // Act
      final result = await registerUseCase(
          userParams.copyWith(phoneNumber: "98604521")); // Invalid phone number
      // Assert
      expect(result, const Left(ApiFailure(message: "Invalid phone number")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('should return Failure when any of the required fields is empty',
        () async {
      // Arrange
      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "One or more credentials is empty")));

      // Act
      final result = await registerUseCase(userParams.copyWith(userName: ""));

      // Assert
      expect(result,
          const Left(ApiFailure(message: "One or more credentials is empty")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('should return Failure when there is a server error', () async {
      // Arrange
      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Internal Server Error")));

      // Act
      final result = await registerUseCase(userParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Internal Server Error")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('should register user successfully and return Right(null)', () async {
      // Arrange
      when(() => repository.registerUser(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await registerUseCase(userParams);

      // Assert
      expect(result, const Right(null));
      verify(() => repository.registerUser(any())).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
