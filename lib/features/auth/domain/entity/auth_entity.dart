import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fullName;
  final String userName;
  final String email;
  final String phoneNumber;
  final String? profileURL;
  final String password;

  const AuthEntity({
    this.userId,
    required this.fullName,
    required this.userName,
    this.profileURL,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [userId, fullName, userName, profileURL, phoneNumber, email, password];
}
