import 'package:equatable/equatable.dart';

class SeatEntity extends Equatable {
  final String code; // "a" (available), "h" (held), "r" (booked)
  final DateTime? holdExpiresAt;
  final String? holdId;
  final String? bookingId;
  final String id;

  const SeatEntity({
    required this.code,
    this.holdExpiresAt,
    this.holdId,
    this.bookingId,
    required this.id,
  });

  @override
  List<Object?> get props => [code, holdExpiresAt, holdId, bookingId, id];
}

class SectionEntity extends Equatable {
  final int section;
  final List<List<SeatEntity>> rows;

  const SectionEntity({
    required this.section,
    required this.rows,
  });

  @override
  List<Object> get props => [section, rows];
}

class SeatLayoutEntity extends Equatable {
  final List<SectionEntity> seatGrid;
  final double price;

  const SeatLayoutEntity({
    required this.seatGrid,
    required this.price,
  });

  @override
  List<Object> get props => [seatGrid, price];
}

class SeatPosition extends Equatable {
  final int section;
  final int row;
  final int seatNumber;

  const SeatPosition({
    required this.section,
    required this.row,
    required this.seatNumber,
  });

  @override
  List<Object> get props => [section, row, seatNumber];
}

class HoldResponseEntity extends Equatable {
  final String message;
  final String holdId;
  final String bookingId;
  final DateTime expiresAt;

  const HoldResponseEntity({
    required this.message,
    required this.holdId,
    required this.bookingId,
    required this.expiresAt,
  });

  @override
  List<Object> get props => [message, holdId, bookingId, expiresAt];
}

class BookingResponseEntity extends Equatable {
  final String message;
  final String confirmationCode;
  final Map<String, dynamic> bookingDetails;

  const BookingResponseEntity({
    required this.message,
    required this.confirmationCode,
    required this.bookingDetails,
  });

  @override
  List<Object> get props => [message, confirmationCode, bookingDetails];
}