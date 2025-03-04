import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

import 'package:ClickEt/app/constants/hive_table_constant.dart';
import 'package:ClickEt/features/auth/domain/entity/auth_entity.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String userName;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String phoneNumber;
  @HiveField(5)
  final String password;
  @HiveField(6)
  final String profileURL;
  @HiveField(7)
  final String? passwordResetToken;
  @HiveField(8)
  final String? passwordResetExpiry;
  @HiveField(9)
  final String? refreshTokenExpiry;

  AuthHiveModel({
    String? userId,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    String? profileURL,
    String? passwordResetToken,
    String? passwordResetExpiry,
    String? refreshTokenExpiry,
  })  : userId = userId ?? const Uuid().v4(),
        passwordResetExpiry = passwordResetExpiry ?? "",
        passwordResetToken = passwordResetToken ?? "",
        refreshTokenExpiry = refreshTokenExpiry ?? "",
        profileURL = profileURL ?? "";

  // Initial Constructor
  const AuthHiveModel.initial()
      : userId = '',
        fullName = '',
        userName = '',
        profileURL = '',
        email = '',
        phoneNumber = '',
        password = '',
        passwordResetExpiry = "",
        passwordResetToken = "",
        refreshTokenExpiry = "";

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity authEntity) {
    return AuthHiveModel(
      userId: authEntity.userId,
      fullName: authEntity.fullName,
      userName: authEntity.userName,
      email: authEntity.email,
      profileURL: authEntity.profileURL,
      phoneNumber: authEntity.phoneNumber,
      password: authEntity.password,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      fullName: fullName,
      userName: userName,
      profileURL: profileURL,
      phoneNumber: phoneNumber,
      password: password,
      email: email,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        fullName,
        userName,
        email,
        phoneNumber,
        password,
        profileURL,
        passwordResetToken,
        passwordResetExpiry,
        refreshTokenExpiry
      ];
}
