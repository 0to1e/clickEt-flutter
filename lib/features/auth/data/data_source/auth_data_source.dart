import 'dart:io';

import 'package:ClickEt/features/auth/domain/entity/auth_entity.dart';


abstract interface class IAuthDataSource {
  Future<dynamic> loginUser(String username, String password);

  Future<void> registerUser(AuthEntity student);

  Future<AuthEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);
}
