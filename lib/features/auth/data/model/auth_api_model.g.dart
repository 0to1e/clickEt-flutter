// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      fullName: json['fullName'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      role: json['role'] as String?,
      passwordResetToken: json['password_reset_token'] as String?,
      passwordResetExpiry: json['password_reset_expiry'] == null
          ? null
          : DateTime.parse(json['password_reset_expiry'] as String),
      refreshToken: json['refresh_token'] as String?,
      refreshTokenExpiry: json['refresh_token_expiry'] == null
          ? null
          : DateTime.parse(json['refresh_token_expiry'] as String),
      profileURL: json['profile_URL'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'userName': instance.userName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'role': instance.role,
      'password_reset_token': instance.passwordResetToken,
      'password_reset_expiry': instance.passwordResetExpiry?.toIso8601String(),
      'refresh_token': instance.refreshToken,
      'refresh_token_expiry': instance.refreshTokenExpiry?.toIso8601String(),
      'profile_URL': instance.profileURL,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
    };
