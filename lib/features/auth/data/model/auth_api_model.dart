import 'package:ClickEt/features/auth/domain/entity/auth_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'full_name')
  final String fullName;
  @JsonKey(name: 'user_name')
  final String userName;
  @JsonKey(name: 'profile_URL')
  final String? profileURL;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber; // Made optional
  final String email;
  @JsonKey(includeIfNull: false) // Exclude if null/missing
  final String? password;      // Made optional
  final String? role;
  @JsonKey(name: 'password_reset_token')
  final String? passwordResetToken;
  @JsonKey(name: 'password_reset_expiry')
  final DateTime? passwordResetExpiry;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  @JsonKey(name: 'refresh_token_expiry')
  final DateTime? refreshTokenExpiry;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? version;

  const AuthApiModel({
    this.id,
    required this.fullName,
    required this.userName,
    this.profileURL,
    this.phoneNumber, // Optional
    required this.email,
    this.password,    // Optional
    this.role,
    this.passwordResetToken,
    this.passwordResetExpiry,
    this.refreshToken,
    this.refreshTokenExpiry,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      fullName: fullName,
      userName: userName,
      profileURL: profileURL,
      phoneNumber: phoneNumber ?? '', // Default to empty string if null
      email: email,
      password: password ?? '',       // Default to empty string if null
      role: role,
      passwordResetToken: passwordResetToken,
      passwordResetExpiry: passwordResetExpiry,
      refreshToken: refreshToken,
      refreshTokenExpiry: refreshTokenExpiry,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        userName,
        profileURL,
        phoneNumber,
        email,
        password,
        role,
        passwordResetToken,
        passwordResetExpiry,
        refreshToken,
        refreshTokenExpiry,
        createdAt,
        updatedAt,
        version,
      ];
}