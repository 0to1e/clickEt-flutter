part of "seat_bloc.dart";

abstract class SeatEvent extends Equatable {
  const SeatEvent();
  @override
  List<Object> get props => [];
}

class FetchSeatLayoutEvent extends SeatEvent {
  final String screeningId;
  const FetchSeatLayoutEvent(this.screeningId);
  @override
  List<Object> get props => [screeningId];
}

class SelectSeatEvent extends SeatEvent {
  final String seatId;
  const SelectSeatEvent(this.seatId);
  @override
  List<Object> get props => [seatId];
}

class HoldSeatsEvent extends SeatEvent {
  const HoldSeatsEvent();
}

class ReleaseHoldEvent extends SeatEvent {
  const ReleaseHoldEvent();
}

class ConfirmBookingEvent extends SeatEvent {
  const ConfirmBookingEvent();
}