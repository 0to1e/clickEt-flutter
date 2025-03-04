import 'dart:io';

import 'package:ClickEt/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/features/auth/domain/entity/auth_entity.dart';
import 'package:ClickEt/features/auth/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      await _authRemoteDataSource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> loginUser(
      String username, String password) async {
    try {
      final response =
          await _authRemoteDataSource.loginUser(username, password);
      return Right(response);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final uploadedUrl =
          await _authRemoteDataSource.uploadProfilePicture(file);
      return Right(uploadedUrl);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthEntity>> getUserStatus() async {
    try {
      final user = await _authRemoteDataSource.getUserStatus();
      return Right(user);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _authRemoteDataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String username) async {
    try {
      await _authRemoteDataSource.deleteUser(username);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
