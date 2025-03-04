import 'package:ClickEt/features/bookings/domain/entity/booking_entity.dart';
import 'package:ClickEt/features/bookings/domain/usecase/get_history_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_history_event.dart';
part 'booking_history_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetBookingHistoryUseCase _getBookingHistoryUseCase;

  BookingBloc(this._getBookingHistoryUseCase) : super(const BookingState()) {
    on<FetchBookingHistoryEvent>(_onFetchBookingHistory);
    on<DownloadTicketEvent>(_onDownloadTicket);
  }

  Future<void> _onFetchBookingHistory(
    FetchBookingHistoryEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _getBookingHistoryUseCase();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (bookings) => emit(state.copyWith(isLoading: false, bookings: bookings)),
    );
  }

  Future<void> _onDownloadTicket(
    DownloadTicketEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(isDownloading: true, downloadError: null));

    emit(state.copyWith(isDownloading: false));
  }
}
