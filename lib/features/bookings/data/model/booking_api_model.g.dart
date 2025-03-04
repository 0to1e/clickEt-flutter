// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingApiModel _$BookingApiModelFromJson(Map<String, dynamic> json) =>
    BookingApiModel(
      bookingId: json['bookingId'] as String,
      confirmationCode: json['confirmationCode'] as String,
      status: json['status'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      createdAt: json['createdAt'] as String,
      user: UserApiModel.fromJson(json['user'] as Map<String, dynamic>),
      screening:
          ScreeningApiModel.fromJson(json['screening'] as Map<String, dynamic>),
      payment:
          PaymentApiModel.fromJson(json['payment'] as Map<String, dynamic>),
      seats: (json['seats'] as List<dynamic>)
          .map((e) => SeatApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookingApiModelToJson(BookingApiModel instance) =>
    <String, dynamic>{
      'bookingId': instance.bookingId,
      'confirmationCode': instance.confirmationCode,
      'status': instance.status,
      'totalPrice': instance.totalPrice,
      'createdAt': instance.createdAt,
      'user': instance.user,
      'screening': instance.screening,
      'payment': instance.payment,
      'seats': instance.seats,
    };

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
    };

ScreeningApiModel _$ScreeningApiModelFromJson(Map<String, dynamic> json) =>
    ScreeningApiModel(
      date: json['date'] as String,
      movieName: json['movieName'] as String,
      posterUrl: json['posterUrl'] as String,
      theatreName: json['theatreName'] as String,
      hallName: json['hallName'] as String,
    );

Map<String, dynamic> _$ScreeningApiModelToJson(ScreeningApiModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'movieName': instance.movieName,
      'posterUrl': instance.posterUrl,
      'theatreName': instance.theatreName,
      'hallName': instance.hallName,
    };

PaymentApiModel _$PaymentApiModelFromJson(Map<String, dynamic> json) =>
    PaymentApiModel(
      method: json['method'] as String,
      paidAmount: (json['paidAmount'] as num).toDouble(),
      paidAt: json['paidAt'] as String,
    );

Map<String, dynamic> _$PaymentApiModelToJson(PaymentApiModel instance) =>
    <String, dynamic>{
      'method': instance.method,
      'paidAmount': instance.paidAmount,
      'paidAt': instance.paidAt,
    };

SeatApiModel _$SeatApiModelFromJson(Map<String, dynamic> json) => SeatApiModel(
      seatId: json['seatId'] as String,
      section: (json['section'] as num).toInt(),
      row: (json['row'] as num).toInt(),
      seatNumber: (json['seatNumber'] as num).toInt(),
    );

Map<String, dynamic> _$SeatApiModelToJson(SeatApiModel instance) =>
    <String, dynamic>{
      'seatId': instance.seatId,
      'section': instance.section,
      'row': instance.row,
      'seatNumber': instance.seatNumber,
    };
