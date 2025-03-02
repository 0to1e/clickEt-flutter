import 'package:ClickEt/core/error/failure.dart';
import 'package:ClickEt/features/screenig/domain/entity/screening_entity.dart';
import 'package:ClickEt/features/screenig/domain/usecase/get_screening_by_movie_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'screening_state.dart';
part 'screening_event.dart';

// class ScreeningBloc extends Bloc<ScreeningEvent, ScreeningState> {
//   final GetScreeningsByMovieUseCase getScreeningsByMovieUseCase;

//   ScreeningBloc({required this.getScreeningsByMovieUseCase})
//       : super(const ScreeningState()) {
//     on<FetchScreeningsEvent>(_onFetchScreenings);
//     on<SelectDateEvent>(_onSelectDate);
//     on<SelectTheatreEvent>(_onSelectTheatre);
//     on<SelectTimeEvent>(_onSelectTime);
//     on<SelectHallEvent>(_onSelectHall);
//   }

//   Future<void> _onFetchScreenings(
//     FetchScreeningsEvent event,
//     Emitter<ScreeningState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true));
//     final result = await getScreeningsByMovieUseCase(
//         GetScreeningsByMovieParams(movieId: event.movieId));
//     result.fold(
//       (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
//       (screenings) => emit(state.copyWith(isLoading: false, screenings: screenings)),
//     );
//   }

//   void _onSelectDate(SelectDateEvent event, Emitter<ScreeningState> emit) {
//     emit(state.copyWith(
//       selectedDate: event.date,
//       selectedTheatre: null, // Reset downstream
//       selectedTime: null,
//       selectedHall: null,
//     ));
//   }

//   void _onSelectTheatre(SelectTheatreEvent event, Emitter<ScreeningState> emit) {
//     emit(state.copyWith(
//       selectedTheatre: event.theatre,
//       selectedTime: null, // Reset downstream
//       selectedHall: null,
//     ));
//   }

//   void _onSelectTime(SelectTimeEvent event, Emitter<ScreeningState> emit) {
//     emit(state.copyWith(
//       selectedTime: event.time,
//       selectedHall: null, // Reset downstream
//     ));
//   }

//   void _onSelectHall(SelectHallEvent event, Emitter<ScreeningState> emit) {
//     emit(state.copyWith(selectedHall: event.hall));
//   }
// }

class ScreeningBloc extends Bloc<ScreeningEvent, ScreeningState> {
  final GetScreeningsByMovieUseCase getScreeningsByMovieUseCase;

  ScreeningBloc({required this.getScreeningsByMovieUseCase})
      : super(const ScreeningState()) {
    on<FetchScreeningsEvent>(_onFetchScreenings);
    on<SelectDateEvent>(_onSelectDate);
    on<SelectTheatreEvent>(_onSelectTheatre);
    on<SelectTimeEvent>(_onSelectTime);
    on<SelectHallEvent>(_onSelectHall);
  }

  Future<void> _onFetchScreenings(
    FetchScreeningsEvent event,
    Emitter<ScreeningState> emit,
  ) async {
    debugPrint('Fetching screenings for movie ID: ${event.movieId}');
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await getScreeningsByMovieUseCase(
        GetScreeningsByMovieParams(movieId: event.movieId));
    result.fold(
      (failure) {
        if (failure is ApiFailure) {
          debugPrint('No screenings found for this movie');
          emit(state.copyWith(
              isLoading: false, screenings: [], errorMessage: null));
        } else {
          debugPrint('Error fetching screenings: ${failure.message}');
          emit(state.copyWith(
              isLoading: false, screenings: [], errorMessage: failure.message));
        }
      },
      (screenings) {
        debugPrint('Screenings fetched successfully: ${screenings.length}');
        emit(state.copyWith(
            isLoading: false, screenings: screenings, errorMessage: null));
      },
    );
  }

  void _onSelectDate(SelectDateEvent event, Emitter<ScreeningState> emit) {
    debugPrint('Date selected: ${event.date}');
    emit(state.copyWith(
      selectedDate: event.date,
      selectedTheatre: null, // Reset downstream selections
      selectedTime: null,
      selectedHall: null,
    ));
  }

  void _onSelectTheatre(
      SelectTheatreEvent event, Emitter<ScreeningState> emit) {
    debugPrint('Theatre selected: ${event.theatre}');
    emit(state.copyWith(
      selectedTheatre: event.theatre,
      selectedTime: null, // Reset downstream selections
      selectedHall: null,
    ));
  }

  void _onSelectTime(SelectTimeEvent event, Emitter<ScreeningState> emit) {
    debugPrint('Time selected: ${event.time}');
    emit(state.copyWith(
      selectedTime: event.time,
      selectedHall: null, // Reset downstream selection
    ));
  }

  void _onSelectHall(SelectHallEvent event, Emitter<ScreeningState> emit) {
    debugPrint('Hall selected: ${event.hall}');
    emit(state.copyWith(selectedHall: event.hall));
  }
}
