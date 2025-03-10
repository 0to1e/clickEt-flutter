// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthHiveModelAdapter extends TypeAdapter<AuthHiveModel> {
  @override
  final int typeId = 0;

  @override
  AuthHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthHiveModel(
      userId: fields[0] as String?,
      fullName: fields[1] as String,
      userName: fields[2] as String,
      email: fields[3] as String,
      phoneNumber: fields[4] as String,
      password: fields[5] as String,
      profileURL: fields[6] as String?,
      passwordResetToken: fields[7] as String?,
      passwordResetExpiry: fields[8] as String?,
      refreshTokenExpiry: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AuthHiveModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.password)
      ..writeByte(6)
      ..write(obj.profileURL)
      ..writeByte(7)
      ..write(obj.passwordResetToken)
      ..writeByte(8)
      ..write(obj.passwordResetExpiry)
      ..writeByte(9)
      ..write(obj.refreshTokenExpiry);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
