// lib/features/booking/presentation/view_model/booking_state.dart
part of 'booking_history_bloc.dart';

class BookingState extends Equatable {
  final List<BookingEntity> bookings;
  final bool isLoading;
  final String? errorMessage;
  final bool isDownloading;
  final String? downloadError;

  const BookingState({
    this.bookings = const [],
    this.isLoading = false,
    this.errorMessage,
    this.isDownloading = false,
    this.downloadError,
  });

  BookingState copyWith({
    List<BookingEntity>? bookings,
    bool? isLoading,
    String? errorMessage,
    bool? isDownloading,
    String? downloadError,
  }) {
    return BookingState(
      bookings: bookings ?? this.bookings,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isDownloading: isDownloading ?? this.isDownloading,
      downloadError: downloadError ?? this.downloadError,
    );
  }

  @override
  List<Object?> get props =>
      [bookings, isLoading, errorMessage, isDownloading, downloadError];
}