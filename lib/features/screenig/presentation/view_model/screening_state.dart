part of 'screening_bloc.dart';

// class ScreeningState extends Equatable {
//   final List<ScreeningEntity> screenings;
//   final String? selectedDate;
//   final String? selectedTheatre;
//   final String? selectedTime;
//   final String? selectedHall;
//   final bool isLoading;
//   final String? errorMessage;
//   final String? selectedScreeningId;

//   const ScreeningState({
//     this.screenings = const [],
//     this.selectedDate,
//     this.selectedTheatre,
//     this.selectedTime,
//     this.selectedHall,
//     this.isLoading = false,
//     this.errorMessage,
//     this.selectedScreeningId,
//   });

//   ScreeningState copyWith({
//     List<ScreeningEntity>? screenings,
//     String? selectedDate,
//     String? selectedTheatre,
//     String? selectedTime,
//     String? selectedHall,
//     bool? isLoading,
//     String? errorMessage,
//     String? selectedScreeningId,
//   }) {
//     return ScreeningState(
//       screenings: screenings ?? this.screenings,
//       selectedDate: selectedDate ?? this.selectedDate,
//       selectedTheatre: selectedTheatre ?? this.selectedTheatre,
//       selectedTime: selectedTime ?? this.selectedTime,
//       selectedHall: selectedHall ?? this.selectedHall,
//       isLoading: isLoading ?? this.isLoading,
//       errorMessage: errorMessage ?? this.errorMessage,
//       selectedScreeningId: selectedScreeningId ?? this.selectedScreeningId,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         screenings,
//         selectedDate,
//         selectedTheatre,
//         selectedTime,
//         selectedHall,
//         isLoading,
//         errorMessage,
//         selectedScreeningId,
//       ];
// }



class ScreeningState extends Equatable {
  final List<ScreeningEntity> screenings;
  final String? selectedDate;
  final String? selectedTheatre;
  final String? selectedTime;
  final String? selectedHall;
  final bool isLoading;
  final String? errorMessage;

  const ScreeningState({
    this.screenings = const [],
    this.selectedDate,
    this.selectedTheatre,
    this.selectedTime,
    this.selectedHall,
    this.isLoading = false,
    this.errorMessage,
  });

  ScreeningState copyWith({
    List<ScreeningEntity>? screenings,
    String? selectedDate,
    String? selectedTheatre,
    String? selectedTime,
    String? selectedHall,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ScreeningState(
      screenings: screenings ?? this.screenings,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTheatre: selectedTheatre ?? this.selectedTheatre,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedHall: selectedHall ?? this.selectedHall,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        screenings,
        selectedDate,
        selectedTheatre,
        selectedTime,
        selectedHall,
        isLoading,
        errorMessage,
      ];
}