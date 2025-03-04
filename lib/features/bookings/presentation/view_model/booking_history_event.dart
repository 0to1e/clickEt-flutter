part of 'booking_history_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
}

class FetchBookingHistoryEvent extends BookingEvent {
  @override
  List<Object> get props => [];
}

class DownloadTicketEvent extends BookingEvent {
  final String bookingId;

  const DownloadTicketEvent(this.bookingId);

  @override
  List<Object> get props => [bookingId];
}