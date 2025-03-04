import 'package:ClickEt/features/screenig/domain/entity/screening_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'screening_api_model.g.dart';

@JsonSerializable()
class ScreeningApiModel {
  @JsonKey(name: '_id')
  final String screeningId;
  @JsonKey(name: 'theatreId')
  final TheatreId theatreId;
  @JsonKey(name: 'hallId')
  final HallId hallId;
  final String startTime;
  final double finalPrice;
  final String status;

  ScreeningApiModel({
    required this.screeningId,
    required this.theatreId,
    required this.hallId,
    required this.startTime,
    required this.finalPrice,
    required this.status,
  });

  factory ScreeningApiModel.fromJson(Map<String, dynamic> json) =>
      _$ScreeningApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScreeningApiModelToJson(this);

  ScreeningEntity toEntity() {
    return ScreeningEntity(
      screeningId: screeningId,
      theatreName: theatreId.name,
      hallName: hallId.name,
      startTime: DateTime.parse(startTime),
      finalPrice: finalPrice,
      status: status,
    );
  }
}

@JsonSerializable()
class TheatreId {
  final String name;

  TheatreId({required this.name});

  factory TheatreId.fromJson(Map<String, dynamic> json) =>
      _$TheatreIdFromJson(json);

  Map<String, dynamic> toJson() => _$TheatreIdToJson(this);
}

@JsonSerializable()
class HallId {
  final String name;

  HallId({required this.name});

  factory HallId.fromJson(Map<String, dynamic> json) => _$HallIdFromJson(json);

  Map<String, dynamic> toJson() => _$HallIdToJson(this);
}