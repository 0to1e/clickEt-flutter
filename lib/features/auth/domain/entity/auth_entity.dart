import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fullName;
  final String userName;
  final String? profileURL;
  final String phoneNumber;
  final String email;
  final String password;
  final String? role;
  final String? passwordResetToken;
  final DateTime? passwordResetExpiry;
  final String? refreshToken;
  final DateTime? refreshTokenExpiry;

  const AuthEntity({
    this.userId,
    required this.fullName,
    required this.userName,
    this.profileURL,
    required this.phoneNumber,
    required this.email,
    required this.password,
    this.role,
    this.passwordResetToken,
    this.passwordResetExpiry,
    this.refreshToken,
    this.refreshTokenExpiry,
  });
  AuthEntity copyWith({
    String? userId,
    String? fullName,
    String? userName,
    String? profileURL,
    String? phoneNumber,
    String? email,
    String? password,
    String? role,
    String? passwordResetToken,
    DateTime? passwordResetExpiry,
    String? refreshToken,
    DateTime? refreshTokenExpiry,
  }) {
    return AuthEntity(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      userName: userName ?? this.userName,
      profileURL: profileURL ?? this.profileURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      passwordResetToken: passwordResetToken ?? this.passwordResetToken,
      passwordResetExpiry: passwordResetExpiry ?? this.passwordResetExpiry,
      refreshToken: refreshToken ?? this.refreshToken,
      refreshTokenExpiry: refreshTokenExpiry ?? this.refreshTokenExpiry,
    );
  }

  const AuthEntity.empty()
      : userId = "",
        fullName = "",
        userName = "",
        profileURL = "",
        phoneNumber = "",
        email = "",
        password = "",
        role = "",
        passwordResetToken = "",
        passwordResetExpiry = null,
        refreshToken = "",
        refreshTokenExpiry = null;

  @override
  List<Object?> get props => [
        userId,
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
      ];
}
