import 'package:ClickEt/features/seats/domain/entity/seat_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_api_model.g.dart';

@JsonSerializable()
class SeatApiModel {
  final String code;
  final DateTime? holdExpiresAt;
  final String? holdId;
  final String? bookingId;
  @JsonKey(name: '_id')
  final String id;

  const SeatApiModel({
    required this.code,
    this.holdExpiresAt,
    this.holdId,
    this.bookingId,
    required this.id,
  });

  factory SeatApiModel.fromJson(Map<String, dynamic> json) => _$SeatApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$SeatApiModelToJson(this);

  SeatEntity toEntity() => SeatEntity(
        code: code,
        holdExpiresAt: holdExpiresAt,
        holdId: holdId,
        bookingId: bookingId,
        id: id,
      );
}

@JsonSerializable()
class SectionApiModel {
  final int section;
  final List<List<SeatApiModel>> rows;

  const SectionApiModel({
    required this.section,
    required this.rows,
  });

  factory SectionApiModel.fromJson(Map<String, dynamic> json) => _$SectionApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$SectionApiModelToJson(this);

  SectionEntity toEntity() => SectionEntity(
        section: section,
        rows: rows.map((row) => row.map((seat) => seat.toEntity()).toList()).toList(),
      );
}

@JsonSerializable()
class SeatLayoutApiModel {
  final List<SectionApiModel> seatGrid;
  final double price;

  const SeatLayoutApiModel({
    required this.seatGrid,
    required this.price,
  });

  factory SeatLayoutApiModel.fromJson(Map<String, dynamic> json) => _$SeatLayoutApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$SeatLayoutApiModelToJson(this);

  SeatLayoutEntity toEntity() => SeatLayoutEntity(
        seatGrid: seatGrid.map((section) => section.toEntity()).toList(),
        price: price,
      );
}