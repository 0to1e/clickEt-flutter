import 'dart:io';

import 'package:ClickEt/features/auth/data/data_source/auth_data_source.dart';
import 'package:ClickEt/features/auth/data/model/auth_hive_model.dart';
import 'package:ClickEt/features/auth/domain/entity/auth_entity.dart';
import 'package:ClickEt/network/hive_service.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    return Future.value(const AuthEntity(
      userId: "",
      fullName: "",
      userName: "",
      email: '',
      phoneNumber: "",
      profileURL: "",
      password: "",
    ));
  }

  @override
  Future<String> loginUser(String username, String password) async {
    try {
      await _hiveService.login(username, password);
      return Future.value("Success");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity student) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(student);

      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    throw UnimplementedError();
  }
}
