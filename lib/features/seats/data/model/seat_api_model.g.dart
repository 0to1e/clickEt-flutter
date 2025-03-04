// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatApiModel _$SeatApiModelFromJson(Map<String, dynamic> json) => SeatApiModel(
      code: json['code'] as String,
      holdExpiresAt: json['holdExpiresAt'] == null
          ? null
          : DateTime.parse(json['holdExpiresAt'] as String),
      holdId: json['holdId'] as String?,
      bookingId: json['bookingId'] as String?,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$SeatApiModelToJson(SeatApiModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'holdExpiresAt': instance.holdExpiresAt?.toIso8601String(),
      'holdId': instance.holdId,
      'bookingId': instance.bookingId,
      '_id': instance.id,
    };

SectionApiModel _$SectionApiModelFromJson(Map<String, dynamic> json) =>
    SectionApiModel(
      section: (json['section'] as num).toInt(),
      rows: (json['rows'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => SeatApiModel.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$SectionApiModelToJson(SectionApiModel instance) =>
    <String, dynamic>{
      'section': instance.section,
      'rows': instance.rows,
    };

SeatLayoutApiModel _$SeatLayoutApiModelFromJson(Map<String, dynamic> json) =>
    SeatLayoutApiModel(
      seatGrid: (json['seatGrid'] as List<dynamic>)
          .map((e) => SectionApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$SeatLayoutApiModelToJson(SeatLayoutApiModel instance) =>
    <String, dynamic>{
      'seatGrid': instance.seatGrid,
      'price': instance.price,
    };
