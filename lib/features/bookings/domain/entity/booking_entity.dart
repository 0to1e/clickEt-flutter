import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String bookingId;
  final String confirmationCode;
  final String status;
  final double totalPrice;
  final String createdAt;
  final String userFullName;
  final String screeningDate;
  final String movieName;
  final String posterUrl;
  final String theatreName;
  final String hallName;
  final String paymentMethod;
  final double paidAmount;
  final String paidAt;
  final List<SeatEntity> seats;
  final List<int>? pdfData; 

  const BookingEntity({
    required this.bookingId,
    required this.confirmationCode,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    required this.userFullName,
    required this.screeningDate,
    required this.movieName,
    required this.posterUrl,
    required this.theatreName,
    required this.hallName,
    required this.paymentMethod,
    required this.paidAmount,
    required this.paidAt,
    required this.seats,
    this.pdfData,
  });

  BookingEntity copyWith({
    String? bookingId,
    String? confirmationCode,
    String? status,
    double? totalPrice,
    String? createdAt,
    String? userFullName,
    String? screeningDate,
    String? movieName,
    String? posterUrl,
    String? theatreName,
    String? hallName,
    String? paymentMethod,
    double? paidAmount,
    String? paidAt,
    List<SeatEntity>? seats,
    List<int>? pdfData,
  }) {
    return BookingEntity(
      bookingId: bookingId ?? this.bookingId,
      confirmationCode: confirmationCode ?? this.confirmationCode,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt ?? this.createdAt,
      userFullName: userFullName ?? this.userFullName,
      screeningDate: screeningDate ?? this.screeningDate,
      movieName: movieName ?? this.movieName,
      posterUrl: posterUrl ?? this.posterUrl,
      theatreName: theatreName ?? this.theatreName,
      hallName: hallName ?? this.hallName,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paidAmount: paidAmount ?? this.paidAmount,
      paidAt: paidAt ?? this.paidAt,
      seats: seats ?? this.seats,
      pdfData: pdfData ?? this.pdfData,
    );
  }

  @override
  List<Object?> get props => [
        bookingId,
        confirmationCode,
        status,
        totalPrice,
        createdAt,
        userFullName,
        screeningDate,
        movieName,
        posterUrl,
        theatreName,
        hallName,
        paymentMethod,
        paidAmount,
        paidAt,
        seats,
        pdfData,
      ];
}

class SeatEntity extends Equatable {
  final String seatId;
  final int section;
  final int row;
  final int seatNumber;

  const SeatEntity({
    required this.seatId,
    required this.section,
    required this.row,
    required this.seatNumber,
  });

  @override
  List<Object> get props => [seatId, section, row, seatNumber];
}