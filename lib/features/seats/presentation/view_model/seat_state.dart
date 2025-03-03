part of "seat_bloc.dart";

class SeatState extends Equatable {
  final SeatLayoutEntity? seatLayout; // The seat grid data
  final Set<String> selectedSeats; // e.g., {"G10", "G11"}
  final String? holdId; // ID of the hold when seats are held
  final DateTime? holdExpiresAt; // Expiration time of the hold
  final Duration? holdRemainingTime; // Remaining time before hold expires
  final String bookingStep; // 'select', 'hold', 'confirmed'
  final bool isLoading; // Loading state for async operations
  final String errorMessage; // Error messages for UI feedback
  final BookingResponseEntity? bookingResponse; // Response after booking confirmation

  const SeatState({
    this.seatLayout,
    this.selectedSeats = const {},
    this.holdId,
    this.holdExpiresAt,
    this.holdRemainingTime,
    this.bookingStep = 'select',
    this.isLoading = false,
    this.errorMessage = '',
    this.bookingResponse,
  });

  SeatState copyWith({
    SeatLayoutEntity? seatLayout,
    Set<String>? selectedSeats,
    String? holdId,
    DateTime? holdExpiresAt,
    Duration? holdRemainingTime,
    String? bookingStep,
    bool? isLoading,
    String? errorMessage,
    BookingResponseEntity? bookingResponse,
  }) {
    return SeatState(
      seatLayout: seatLayout ?? this.seatLayout,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      holdId: holdId ?? this.holdId,
      holdExpiresAt: holdExpiresAt ?? this.holdExpiresAt,
      holdRemainingTime: holdRemainingTime ?? this.holdRemainingTime,
      bookingStep: bookingStep ?? this.bookingStep,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      bookingResponse: bookingResponse ?? this.bookingResponse,
    );
  }

  @override
  List<Object?> get props => [
        seatLayout,
        selectedSeats,
        holdId,
        holdExpiresAt,
        holdRemainingTime,
        bookingStep,
        isLoading,
        errorMessage,
        bookingResponse,
      ];
}