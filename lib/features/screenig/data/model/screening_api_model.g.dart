// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screening_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScreeningApiModel _$ScreeningApiModelFromJson(Map<String, dynamic> json) =>
    ScreeningApiModel(
      screeningId: json['_id'] as String,
      theatreId: TheatreId.fromJson(json['theatreId'] as Map<String, dynamic>),
      hallId: HallId.fromJson(json['hallId'] as Map<String, dynamic>),
      startTime: json['startTime'] as String,
      finalPrice: (json['finalPrice'] as num).toDouble(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$ScreeningApiModelToJson(ScreeningApiModel instance) =>
    <String, dynamic>{
      '_id': instance.screeningId,
      'theatreId': instance.theatreId,
      'hallId': instance.hallId,
      'startTime': instance.startTime,
      'finalPrice': instance.finalPrice,
      'status': instance.status,
    };

TheatreId _$TheatreIdFromJson(Map<String, dynamic> json) => TheatreId(
      name: json['name'] as String,
    );

Map<String, dynamic> _$TheatreIdToJson(TheatreId instance) => <String, dynamic>{
      'name': instance.name,
    };

HallId _$HallIdFromJson(Map<String, dynamic> json) => HallId(
      name: json['name'] as String,
    );

Map<String, dynamic> _$HallIdToJson(HallId instance) => <String, dynamic>{
      'name': instance.name,
    };
