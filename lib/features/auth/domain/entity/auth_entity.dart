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
