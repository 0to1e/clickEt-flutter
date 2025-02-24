import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:ClickEt/app/usecase/usecase.dart';
import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({
    required this.username,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : username = '',
        password = '';

  @override
  List<Object> get props => [username, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    final result = await repository.loginUser(params.username, params.password);

    return result.fold(
      (failure) => Left(failure),
      (response) {
        final String? accessToken = response.data['accessToken'];

        if (accessToken == null) {
          return const Left(
              ApiFailure(message: "Access token not found in response"));
        }

        return Right(accessToken);
      },
    );
  }
}