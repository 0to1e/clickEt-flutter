import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ClickEt/app/usecase/usecase.dart';
import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/features/auth/domain/entity/auth_entity.dart';
import 'package:ClickEt/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String fullName;
  final String userName;
  final String email;
  final String phoneNumber;
  final String password;

  const RegisterUserParams({
    required this.fullName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  //intial constructor
  const RegisterUserParams.initial()
      : fullName = "",
        userName = "",
        email = "",
        phoneNumber = "",
        password = "";

  @override
  List<Object?> get props => [fullName, userName, email, phoneNumber, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fullName: params.fullName,
      userName: params.userName,
      email: params.email,
      phoneNumber: params.phoneNumber,
      password: params.password,
    );
    return repository.registerUser(authEntity);
  }
}