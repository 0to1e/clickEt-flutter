import 'dart:io';

import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/features/auth/domain/entity/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity user);
  Future<Either<Failure, dynamic>> loginUser(String username, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, AuthEntity>> getCurrentUser();
  Future<Either<Failure, AuthEntity>> getUserStatus();
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> deleteUser(String username);
}