import 'package:ClickEt/features/auth/domain/entity/auth_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String fullName;
  final String userName;
  final String email;
  final String phoneNumber;
  final String password;
  final String ?role;
  @JsonKey(name: 'password_reset_token')
  final String ?passwordResetToken;
  @JsonKey(name: 'password_reset_expiry')
  final DateTime ?passwordResetExpiry;
  @JsonKey(name: 'refresh_token')
  final String ?refreshToken;
  @JsonKey(name: 'refresh_token_expiry')
  final DateTime ?refreshTokenExpiry;
  @JsonKey(name: 'profile_URL')
  final String ?profileURL;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int ?version;

  const AuthApiModel({
    this.id,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.role,
    this.passwordResetToken,
    this.passwordResetExpiry,
    this.refreshToken,
    this.refreshTokenExpiry,
    this.profileURL,
    this.createdAt,
    this.updatedAt,
    this.version
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      fullName: fullName,
      userName: userName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      role: role,
      passwordResetToken: passwordResetToken,
      passwordResetExpiry: passwordResetExpiry,
      refreshToken: refreshToken,
      refreshTokenExpiry: refreshTokenExpiry,
      profileURL: profileURL,
    );
  }

  // From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      fullName: entity.fullName,
      userName: entity.userName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        userName,
        email,
        phoneNumber,
        password,
        role,
        passwordResetToken,
        passwordResetExpiry,
        refreshToken,
        refreshTokenExpiry,
        createdAt,
        updatedAt,
        version,
        profileURL,
      ];
}
