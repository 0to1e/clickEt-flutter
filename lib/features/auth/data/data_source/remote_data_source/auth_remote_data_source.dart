import 'dart:io';

import 'package:ClickEt/app/constants/api_constants.dart';
import 'package:ClickEt/features/auth/data/data_source/auth_data_source.dart';
import 'package:ClickEt/features/auth/data/model/auth_api_model.dart';
import 'package:dio/dio.dart';
import 'package:ClickEt/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          'full_name': user.fullName,
          'user_name': user.userName,
          'email': user.email,
          'phone_number': user.phoneNumber,
          'password': user.password,
        },
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Registration failed');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Response> loginUser(String username, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "user_name": username,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last),
      });
      final response = await _dio.patch(
        ApiEndpoints.uploadImage,
        data: formData,
      );
      if (response.statusCode == 200) {
        final String uploadedUrl = response.data['url'];
        return uploadedUrl;
      } else {
        throw Exception('Failed to upload profile picture');
      }
    } catch (e) {
      throw Exception('Upload failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await _dio.post(ApiEndpoints.logout);
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  @override
  Future<AuthEntity> getUserStatus() async {
    try {
      final response = await _dio.get(ApiEndpoints.getUser);
      if (response.statusCode == 200) {
        final userJson = response.data['user'];
        final apiModel = AuthApiModel.fromJson(userJson);
        final entity = apiModel.toEntity();
        return entity;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Failed to fetch user status');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteUser(String username) async {
    try {
      final response =
          await _dio.delete('${ApiEndpoints.deleteUser}/$username');
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
