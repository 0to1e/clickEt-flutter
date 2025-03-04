part of 'screening_bloc.dart';

// abstract class ScreeningEvent extends Equatable {
//   const ScreeningEvent();

//   @override
//   List<Object> get props => [];
// }

// class FetchScreeningsEvent extends ScreeningEvent {
//   final String movieId;

//   const FetchScreeningsEvent(this.movieId);

//   @override
//   List<Object> get props => [movieId];
// }

// class SelectDateEvent extends ScreeningEvent {
//   final String date;

//   const SelectDateEvent(this.date);

//   @override
//   List<Object> get props => [date];
// }

// class SelectTheatreEvent extends ScreeningEvent {
//   final String theatre;

//   const SelectTheatreEvent(this.theatre);

//   @override
//   List<Object> get props => [theatre];
// }

// class SelectTimeEvent extends ScreeningEvent {
//   final String time;

//   const SelectTimeEvent(this.time);

//   @override
//   List<Object> get props => [time];
// }

// class SelectHallEvent extends ScreeningEvent {
//   final String hall;

//   const SelectHallEvent(this.hall);

//   @override
//   List<Object> get props => [hall];
// }



abstract class ScreeningEvent extends Equatable {
  const ScreeningEvent();

  @override
  List<Object> get props => [];
}

class FetchScreeningsEvent extends ScreeningEvent {
  final String movieId;

  const FetchScreeningsEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class SelectDateEvent extends ScreeningEvent {
  final String date;

  const SelectDateEvent(this.date);

  @override
  List<Object> get props => [date];
}

class SelectTheatreEvent extends ScreeningEvent {
  final String theatre;

  const SelectTheatreEvent(this.theatre);

  @override
  List<Object> get props => [theatre];
}

class SelectTimeEvent extends ScreeningEvent {
  final String time;

  const SelectTimeEvent(this.time);

  @override
  List<Object> get props => [time];
}

class SelectHallEvent extends ScreeningEvent {
  final String hall;

  const SelectHallEvent(this.hall);

  @override
  List<Object> get props => [hall];
}