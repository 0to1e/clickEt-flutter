import 'dart:io';
import 'package:ClickEt/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import 'package:ClickEt/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity user);

  Future<Either<Failure, dynamic>> loginUser(
      String username, String password);

  Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, AuthEntity>> getCurrentUser();
}
