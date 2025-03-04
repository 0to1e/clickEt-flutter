// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      fullName: json['full_name'] as String,
      userName: json['user_name'] as String,
      profileURL: json['profile_URL'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String,
      password: json['password'] as String?,
      role: json['role'] as String?,
      passwordResetToken: json['password_reset_token'] as String?,
      passwordResetExpiry: json['password_reset_expiry'] == null
          ? null
          : DateTime.parse(json['password_reset_expiry'] as String),
      refreshToken: json['refresh_token'] as String?,
      refreshTokenExpiry: json['refresh_token_expiry'] == null
          ? null
          : DateTime.parse(json['refresh_token_expiry'] as String),
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
      'full_name': instance.fullName,
      'user_name': instance.userName,
      'profile_URL': instance.profileURL,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      if (instance.password case final value?) 'password': value,
      'role': instance.role,
      'password_reset_token': instance.passwordResetToken,
      'password_reset_expiry': instance.passwordResetExpiry?.toIso8601String(),
      'refresh_token': instance.refreshToken,
      'refresh_token_expiry': instance.refreshTokenExpiry?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
    };
