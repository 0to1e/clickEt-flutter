// lib/features/booking/data/model/booking_api_model.dart
import 'package:ClickEt/features/bookings/domain/entity/booking_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_api_model.g.dart';

@JsonSerializable()
class BookingApiModel {
  @JsonKey(name: 'bookingId')
  final String bookingId;
  @JsonKey(name: 'confirmationCode')
  final String confirmationCode;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'totalPrice')
  final double totalPrice;
  @JsonKey(name: 'createdAt')
  final String createdAt;
  @JsonKey(name: 'user')
  final UserApiModel user;
  @JsonKey(name: 'screening')
  final ScreeningApiModel screening;
  @JsonKey(name: 'payment')
  final PaymentApiModel payment;
  @JsonKey(name: 'seats')
  final List<SeatApiModel> seats;

  BookingApiModel({
    required this.bookingId,
    required this.confirmationCode,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    required this.user,
    required this.screening,
    required this.payment,
    required this.seats,
  });

  factory BookingApiModel.fromJson(Map<String, dynamic> json) =>
      _$BookingApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingApiModelToJson(this);

  BookingEntity toEntity() => BookingEntity(
        bookingId: bookingId,
        confirmationCode: confirmationCode,
        status: status,
        totalPrice: totalPrice,
        createdAt: createdAt,
        userFullName: user.fullName,
        screeningDate: screening.date,
        movieName: screening.movieName,
        posterUrl: screening.posterUrl,
        theatreName: screening.theatreName,
        hallName: screening.hallName,
        paymentMethod: payment.method,
        paidAmount: payment.paidAmount,
        paidAt: payment.paidAt,
        seats: seats.map((seat) => seat.toEntity()).toList(),
      );
}

@JsonSerializable()
class UserApiModel {
  @JsonKey(name: 'fullName')
  final String fullName;

  UserApiModel({required this.fullName});

  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);
}

@JsonSerializable()
class ScreeningApiModel {
  @JsonKey(name: 'date')
  final String date;
  @JsonKey(name: 'movieName')
  final String movieName;
  @JsonKey(name: 'posterUrl')
  final String posterUrl;
  @JsonKey(name: 'theatreName')
  final String theatreName;
  @JsonKey(name: 'hallName')
  final String hallName;

  ScreeningApiModel({
    required this.date,
    required this.movieName,
    required this.posterUrl,
    required this.theatreName,
    required this.hallName,
  });

  factory ScreeningApiModel.fromJson(Map<String, dynamic> json) =>
      _$ScreeningApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScreeningApiModelToJson(this);
}

@JsonSerializable()
class PaymentApiModel {
  @JsonKey(name: 'method')
  final String method;
  @JsonKey(name: 'paidAmount')
  final double paidAmount;
  @JsonKey(name: 'paidAt')
  final String paidAt;

  PaymentApiModel({
    required this.method,
    required this.paidAmount,
    required this.paidAt,
  });

  factory PaymentApiModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentApiModelToJson(this);
}

@JsonSerializable()
class SeatApiModel {
  @JsonKey(name: 'seatId')
  final String seatId;
  @JsonKey(name: 'section')
  final int section;
  @JsonKey(name: 'row')
  final int row;
  @JsonKey(name: 'seatNumber')
  final int seatNumber;

  SeatApiModel({
    required this.seatId,
    required this.section,
    required this.row,
    required this.seatNumber,
  });

  factory SeatApiModel.fromJson(Map<String, dynamic> json) =>
      _$SeatApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatApiModelToJson(this);

  SeatEntity toEntity() => SeatEntity(
        seatId: seatId,
        section: section,
        row: row,
        seatNumber: seatNumber,
      );
}