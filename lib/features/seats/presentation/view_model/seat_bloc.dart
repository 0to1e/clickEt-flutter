import 'dart:async';
import 'package:ClickEt/features/seats/domain/entity/seat_entity.dart';
import 'package:ClickEt/features/seats/domain/use_case/confirm_booking_use_case.dart';
import 'package:ClickEt/features/seats/domain/use_case/get_seat_layout_use_case.dart';
import 'package:ClickEt/features/seats/domain/use_case/hold_seats_use_case.dart';
import 'package:ClickEt/features/seats/domain/use_case/release_hold_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'seat_event.dart';
part 'seat_state.dart';

class SeatBloc extends Bloc<SeatEvent, SeatState> {
  final GetSeatLayoutUseCase getSeatLayoutUseCase;
  final HoldSeatsUseCase holdSeatsUseCase;
  final ReleaseHoldUseCase releaseHoldUseCase;
  final ConfirmBookingUseCase confirmBookingUseCase;

  Timer? _holdTimer;
  String screeningId = '';

  SeatBloc({
    required this.getSeatLayoutUseCase,
    required this.holdSeatsUseCase,
    required this.releaseHoldUseCase,
    required this.confirmBookingUseCase,
  }) : super(const SeatState()) {
    on<FetchSeatLayoutEvent>(_onFetchSeatLayout);
    on<SelectSeatEvent>(_onSelectSeat);
    on<HoldSeatsEvent>(_onHoldSeats);
    on<ReleaseHoldEvent>(_onReleaseHold);
    on<ConfirmBookingEvent>(_onConfirmBooking);
  }

  @override
  Future<void> close() {
    _holdTimer?.cancel();
    return super.close();
  }

  Future<void> _onFetchSeatLayout(
      FetchSeatLayoutEvent event, Emitter<SeatState> emit) async {
    screeningId = event.screeningId;
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await getSeatLayoutUseCase(event.screeningId);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (seatLayout) =>
          emit(state.copyWith(isLoading: false, seatLayout: seatLayout)),
    );
  }

  void _onSelectSeat(SelectSeatEvent event, Emitter<SeatState> emit) {
    if (state.bookingStep != 'select') return;

    final selectedSeats = Set<String>.from(state.selectedSeats);
    if (selectedSeats.contains(event.seatId)) {
      selectedSeats.remove(event.seatId);
    } else if (selectedSeats.length < 10) {
      // Limit to 10 seats as an example
      selectedSeats.add(event.seatId);
    } else {
      emit(state.copyWith(errorMessage: 'You can only select up to 10 seats.'));
      return;
    }
    emit(state.copyWith(selectedSeats: selectedSeats, errorMessage: ''));
  }

  Future<void> _onHoldSeats(
      HoldSeatsEvent event, Emitter<SeatState> emit) async {
    if (state.selectedSeats.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please select seats first'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final seats = state.selectedSeats.map((seatId) {
      final position = _parseSeatId(seatId);
      return SeatPosition(
          section: position.section,
          row: position.row,
          seatNumber: position.seatNumber);
    }).toList();

    final result = await holdSeatsUseCase(screeningId, seats);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (holdResponse) {
        emit(state.copyWith(
          isLoading: false,
          holdId: holdResponse.holdId,
          bookingStep: 'hold',
          holdExpiresAt: holdResponse.expiresAt,
          holdRemainingTime: holdResponse.expiresAt.difference(DateTime.now()),
        ));
        _startHoldTimer(holdResponse.expiresAt);
      },
    );
  }

  Future<void> _onReleaseHold(
      ReleaseHoldEvent event, Emitter<SeatState> emit) async {
    if (state.holdId == null) return;

    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await releaseHoldUseCase(state.holdId!);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) {
        _holdTimer?.cancel();
        emit(state.copyWith(
          isLoading: false,
          holdId: null,
          holdExpiresAt: null,
          holdRemainingTime: null,
          bookingStep: 'select',
          selectedSeats: {},
        ));
      },
    );
  }

  Future<void> _onConfirmBooking(
      ConfirmBookingEvent event, Emitter<SeatState> emit) async {
    if (state.holdId == null) {
      emit(state.copyWith(errorMessage: 'No seats are currently held'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await confirmBookingUseCase(state.holdId!);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (bookingResponse) {
        _holdTimer?.cancel();
        emit(state.copyWith(
          isLoading: false,
          bookingResponse: bookingResponse,
          bookingStep: 'confirmed',
          selectedSeats: {},
        ));
      },
    );
  }

  void _startHoldTimer(DateTime expiresAt) {
    _holdTimer?.cancel();
    final now = DateTime.now();
    Duration remaining = expiresAt.difference(now);

    _holdTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remaining = remaining - const Duration(seconds: 1);
      if (remaining.isNegative) {
        timer.cancel();
        add(const ReleaseHoldEvent());
      } else {
        emit(state.copyWith(holdRemainingTime: remaining));
      }
    });
  }

  SeatPosition _parseSeatId(String seatId) {
    // Parses "G10" into row 'G' and seatNumber 10
    final rowChar = seatId[0];
    final seatNumber = int.parse(seatId.substring(1));
    final rowIndex = rowChar.codeUnitAt(0) - 'A'.codeUnitAt(0);
    return SeatPosition(
        section: 0,
        row: rowIndex,
        seatNumber: seatNumber - 1); // Adjust section if needed
  }
}