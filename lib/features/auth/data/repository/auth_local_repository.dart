import 'dart:io';

import 'package:ClickEt/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:ClickEt/features/auth/domain/entity/auth_entity.dart';
import 'package:ClickEt/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:ClickEt/core/error/failure.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final currentUser = await _authLocalDataSource.getCurrentUser();
      return Right(currentUser);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final token = await _authLocalDataSource.loginUser(email, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      return Right(_authLocalDataSource.registerUser(user));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, void>> deleteUser(String username) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, AuthEntity>> getUserStatus() {
    // TODO: implement getUserStatus
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
